const notionHosts = new Set(["app.notion.com", "www.notion.so", "notion.so"]);
const pageIdPattern = /(?:^|[-/])([a-f0-9]{32}|[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})$/i;

export function isCalendar(value) {
  try {
    return new URL(value).origin === "https://calendar.notion.so";
  } catch {
    return false;
  }
}

export function desktopUrl(value) {
  if (typeof value !== "string") return null;
  let url;
  try {
    url = new URL(value);
  } catch {
    return null;
  }
  if (
    url.protocol !== "https:" || !notionHosts.has(url.hostname) ||
    url.port || url.username || url.password
  ) return null;
  const match = url.pathname.replace(/\/$/, "").match(pageIdPattern);
  if (!match) return null;
  const id = match[1].replaceAll("-", "").toLowerCase();
  return `notion://www.notion.so/${id}${url.search}${url.hash}`;
}
