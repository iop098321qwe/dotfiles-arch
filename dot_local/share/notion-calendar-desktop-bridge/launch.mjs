import { desktopUrl } from "./links.mjs";

export function launchTask(page, document, location) {
  const destination = desktopUrl(page);
  const status = document.getElementById("status");
  if (!destination) {
    status.textContent = "This is not a supported Notion task link.";
    return;
  }
  const desktop = document.getElementById("desktop");
  desktop.href = destination;
  desktop.hidden = false;
  const web = document.getElementById("web");
  web.href = page;
  web.hidden = false;
  status.textContent = "If Notion does not open automatically, click Open Notion Desktop and approve the browser prompt.";
  // An explicit link remains available if Brave blocks a non-gesture launch.
  try {
    location.replace(destination);
  } catch {
    // Keep the trusted-click fallback visible even if automatic launch throws.
  }
}

if (typeof document !== "undefined") {
  launchTask(new URL(location.href).searchParams.get("page"), document, location);
}
