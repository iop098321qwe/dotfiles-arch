(() => {
  "use strict";

  if (![
    "https://calendar.notion.com", "https://calendar.notion.so",
  ].includes(window.location.origin)) return;

  // Content scripts are classic scripts, so keep this small converter in sync
  // with links.mjs. The tests exercise both routes with the same URL cases.
  function desktopUrl(value) {
    if (value instanceof URL) value = value.href;
    if (typeof value !== "string") return null;
    let url;
    try {
      url = new URL(value);
    } catch {
      return null;
    }
    if (
      url.protocol !== "https:" || url.port || url.username || url.password ||
      !["app.notion.com", "www.notion.so", "notion.so"].includes(url.hostname)
    ) return null;
    const match = url.pathname.replace(/\/$/, "").match(
      /(?:^|[-/])([a-f0-9]{32}|[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})$/i,
    );
    if (!match) return null;
    const id = match[1].replaceAll("-", "").toLowerCase();
    return `notion://www.notion.so/${id}${url.search}${url.hash}`;
  }

  function launch(value) {
    // Stay inside the original click gesture: no worker wakeup, new tab,
    // intermediate HTML page, or attempted browser-permission bypass.
    if (!navigator.userActivation.isActive) return false;
    const destination = desktopUrl(value);
    if (!destination) return false;
    try {
      window.location.assign(destination);
      return true;
    } catch {
      return false;
    }
  }

  const originalOpen = window.open;
  window.open = function (...args) {
    // No WindowProxy exists when launching an external app; null also matches
    // the return value of Calendar's usual noopener/noreferrer popup.
    if (launch(args[0])) return null;
    return Reflect.apply(originalOpen, this, args);
  };

  document.addEventListener("click", (event) => {
    if (
      event.defaultPrevented || event.button !== 0 || event.ctrlKey ||
      event.metaKey || event.shiftKey || event.altKey
    ) return;
    const anchor = event.composedPath().find(
      (element) => element instanceof HTMLAnchorElement,
    );
    if (!anchor || anchor.hasAttribute("download")) return;
    // Also cover a programmatic anchor.click() inside the user's button click.
    // The activation check prevents unattended synthetic app launches.
    if (!launch(anchor.href)) return;
    event.preventDefault();
    event.stopImmediatePropagation();
  }, true);
})();
