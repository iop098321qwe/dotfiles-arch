import { desktopUrl, isCalendar } from "./links.mjs";

export function registerBridge(browser) {
  const sources = new Map();
  const routing = new Set();
  const key = (tabId) => `calendar-source-${tabId}`;
  const report = () => console.warn("Calendar desktop handoff failed; retry the link.");

  async function clearSource(tabId) {
    await browser.storage.session.remove(key(tabId));
  }

  async function route(tabId, url) {
    if (!desktopUrl(url) || routing.has(tabId)) return;
    routing.add(tabId);
    try {
      const launch = new URL(browser.runtime.getURL("launch.html"));
      launch.searchParams.set("page", url);
      await browser.tabs.update(tabId, { url: launch.href });
      await clearSource(tabId);
    } finally {
      routing.delete(tabId);
    }
  }

  browser.webNavigation.onCreatedNavigationTarget.addListener((details) => {
    if (details.sourceFrameId !== 0) return;
    // Keep the pending source lookup so a fast destination navigation cannot
    // race the asynchronous tabs.get/storage calls. Session storage survives
    // MV3 worker suspension; it stores only tab IDs, never task URLs.
    const source = browser.tabs.get(details.sourceTabId).then(async (tab) => {
      const allowed = isCalendar(tab.url);
      if (allowed) await browser.storage.session.set({ [key(details.tabId)]: true });
      return allowed;
    });
    sources.set(details.tabId, source);
    return (async () => {
      try {
        if (!await source) return;
        if (desktopUrl(details.url)) {
          await route(details.tabId, details.url);
        } else {
          // Some buttons open about:blank, then assign location later.
          const tab = await browser.tabs.get(details.tabId);
          const destination = tab.pendingUrl || tab.url;
          if (desktopUrl(destination)) await route(details.tabId, destination);
          else if (destination && destination !== "about:blank") {
            await clearSource(details.tabId);
          }
        }
      } finally {
        sources.delete(details.tabId);
      }
    })().catch(report);
  });

  browser.webNavigation.onBeforeNavigate.addListener((details) => {
    if (details.frameId !== 0) return;
    return (async () => {
      const pending = sources.get(details.tabId);
      const fromNewTab = pending ? await pending : Boolean(
        (await browser.storage.session.get(key(details.tabId)))[key(details.tabId)],
      );
      if (!desktopUrl(details.url)) {
        if (fromNewTab && details.url !== "about:blank") await clearSource(details.tabId);
        return;
      }
      // For same-tab navigation, tabs.get still exposes the committed Calendar
      // URL while pendingUrl contains the destination. Never use pendingUrl as
      // the source, and never redirect an independently opened Notion tab.
      const fromCalendar = fromNewTab || isCalendar(
        (await browser.tabs.get(details.tabId)).url,
      );
      if (fromCalendar) await route(details.tabId, details.url);
    })().catch(report);
  });

  browser.tabs.onRemoved.addListener((tabId) => clearSource(tabId).catch(report));
}

if (typeof chrome !== "undefined") registerBridge(chrome);
