"use strict";

const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");
const { pathToFileURL } = require("node:url");
const test = require("node:test");
const extension = path.join(__dirname, "../dot_local/share/notion-calendar-desktop-bridge");
const moduleAt = (name) => import(pathToFileURL(path.join(extension, name)).href);
const id = "0123456789abcdef0123456789abcdef";
const task = `https://app.notion.com/p/Example-Task-${id}`;
const desktop = `notion://www.notion.so/${id}`;
const calendar = "https://calendar.notion.so/";

function setup() {
  const listeners = {};
  const session = {};
  const tabs = new Map([[1, { url: calendar }], [2, { url: "about:blank" }]]);
  const updates = [];
  const event = (name) => ({ addListener: (listener) => { listeners[name] = listener; } });
  const browser = {
    runtime: { getURL: (name) => `chrome-extension://test/${name}` },
    tabs: {
      get: async (tabId) => tabs.get(tabId) || {},
      update: async (tabId, properties) => {
        updates.push({ tabId, ...properties });
        tabs.set(tabId, properties);
      },
      onRemoved: event("removed"),
    },
    storage: { session: {
      get: async (key) => ({ [key]: session[key] }),
      set: async (values) => Object.assign(session, values),
      remove: async (key) => { delete session[key]; },
    } },
    webNavigation: {
      onCreatedNavigationTarget: event("created"),
      onBeforeNavigate: event("before"),
    },
  };
  const created = (url = task, sourceTabId = 1) => listeners.created({
    tabId: 2, sourceTabId, sourceFrameId: 0, url,
  });
  const before = (url = task, tabId = 2, frameId = 0) => listeners.before({
    tabId, frameId, url,
  });
  return { browser, listeners, session, tabs, updates, created, before };
}

async function bridge() {
  const env = setup();
  const { registerBridge } = await moduleAt("background.mjs");
  registerBridge(env.browser);
  return env;
}

test("converts known task hosts, UUIDs, queries, and fragments", async () => {
  const { desktopUrl } = await moduleAt("links.mjs");
  for (const host of ["app.notion.com", "www.notion.so", "notion.so"]) {
    assert.equal(desktopUrl(`https://${host}/Title-${id}/?v=view#block`),
      `${desktop}?v=view#block`);
  }
  assert.equal(desktopUrl("https://www.notion.so/01234567-89AB-CDEF-0123-456789ABCDEF"), desktop);
});

test("rejects unrelated, malformed, credential-bearing, and deceptive URLs", async () => {
  const { desktopUrl, isCalendar } = await moduleAt("links.mjs");
  for (const value of [undefined, {}, "", "about:blank", "/relative",
    "https://app.notion.com/login", `https://evil.example/p/${id}`,
    `https://app.notion.com.evil.example/p/${id}`, `http://app.notion.com/p/${id}`,
    `https://app.notion.com:8443/p/${id}`, `https://user:pass@app.notion.com/p/${id}`,
    `https://app.notion.com/p/prefix${id}`, `https://app.notion.com/p/${id}/other`,
    desktop]) assert.equal(desktopUrl(value), null);
  assert.equal(isCalendar(calendar), true);
  assert.equal(isCalendar("https://calendar.notion.com/"), true);
  assert.equal(isCalendar("https://calendar.notion.so.evil.example/"), false);
  assert.equal(isCalendar("https://calendar.notion.com.evil.example/"), false);
  assert.equal(isCalendar("http://calendar.notion.com/"), false);
});

test("routes a JavaScript-created task tab from Calendar", async () => {
  const env = await bridge();
  await env.created();
  assert.equal(env.updates.length, 1);
  assert.equal(new URL(env.updates[0].url).searchParams.get("page"), task);
  assert.equal(env.updates[0].tabId, 2);
  assert.deepEqual(env.session, {});
});

test("catches about:blank followed by location assignment after worker restart", async () => {
  const env = await bridge();
  await env.created("about:blank");
  assert.equal(env.session["calendar-source-2"], true);
  const { registerBridge } = await moduleAt("background.mjs");
  registerBridge(env.browser);
  await env.before();
  assert.equal(env.updates.length, 1);
});

test("catches a destination navigation racing the source lookup", async () => {
  const env = await bridge();
  await Promise.all([env.created("about:blank"), env.before()]);
  assert.equal(env.updates.length, 1);
});

test("routes a same-tab Calendar navigation", async () => {
  const env = await bridge();
  await env.before(task, 1);
  assert.equal(env.updates.length, 1);
  assert.equal(env.updates[0].tabId, 1);
});

test("recognizes calendar.notion.com for popups and same-tab navigation", async () => {
  for (const method of ["popup", "same-tab"]) {
    const env = await bridge();
    env.tabs.set(1, { url: "https://calendar.notion.com/" });
    if (method === "popup") await env.created();
    else await env.before(task, 1);
    assert.equal(env.updates.length, 1, method);
  }
});

test("does not redirect normal Notion browsing, other sites, or iframes", async () => {
  const env = await bridge();
  env.tabs.set(3, { url: "https://example.com/" });
  await env.created(task, 3);
  await env.before(task, 3);
  await env.before(task, 1, 7);
  await env.listeners.created({ tabId: 2, sourceTabId: 1, sourceFrameId: 7, url: task });
  await env.before("https://example.com/", 1);
  assert.deepEqual(env.updates, []);
});

test("forgets the Calendar source after navigating elsewhere or closing a tab", async () => {
  const env = await bridge();
  await env.created("about:blank");
  await env.before("https://example.com/");
  await env.before();
  assert.deepEqual(env.updates, []);
  await env.created("about:blank");
  await env.listeners.removed(2);
  assert.deepEqual(env.session, {});
});

test("launch page offers a real clickable fallback if auto-launch is blocked", async () => {
  const { launchTask } = await moduleAt("launch.mjs");
  const elements = Object.fromEntries(["status", "desktop", "web"].map(
    (name) => [name, { hidden: true }],
  ));
  const document = { getElementById: (id) => elements[id] };
  const attempted = [];
  launchTask(task, document, { replace(url) { attempted.push(url); throw Error("blocked"); } });
  assert.deepEqual(attempted, [desktop]);
  assert.equal(elements.desktop.href, desktop);
  assert.equal(elements.desktop.hidden, false);
  assert.equal(elements.web.href, task);
  assert.equal(elements.web.hidden, false);
});

test("launch page rejects untrusted destinations", async () => {
  const { launchTask } = await moduleAt("launch.mjs");
  const status = {};
  launchTask("https://evil.example/", { getElementById: () => status }, {
    replace() { assert.fail("must not navigate"); },
  });
  assert.match(status.textContent, /not a supported/);
});

test("manifest grants only the scoped hosts and required navigation/storage APIs", () => {
  const manifest = JSON.parse(fs.readFileSync(path.join(extension, "manifest.json"), "utf8"));
  assert.equal(manifest.manifest_version, 3);
  assert.deepEqual(manifest.permissions, ["webNavigation", "storage"]);
  assert.deepEqual(manifest.host_permissions, [
    "https://calendar.notion.so/*", "https://calendar.notion.com/*",
    "https://app.notion.com/*",
    "https://www.notion.so/*", "https://notion.so/*",
  ]);
  assert.equal(manifest.content_scripts, undefined);
  assert.equal(manifest.background.service_worker, "background.mjs");
  assert.equal(manifest.background.type, "module");
  assert.equal(manifest.web_accessible_resources, undefined);
});
