settings.scrollStepSize = 35;

settings.modeAfterYank = "Normal";

settings.smoothScroll = true;

/**
 * Catppuccin Mocha × Surfingkeys
 * ------------------------------
 * This configuration keeps the spirit of the original theme while introducing:
 *   • Centralised palette definitions for clarity and reuse.
 *   • Carefully structured CSS blocks that highlight Surfingkeys UI regions.
 *   • Complete Catppuccin coverage across Surfingkeys surfaces, including Vim insert-mode dialogs.
 */

const mochaPalette = Object.freeze({
  rosewater: "#f5e0dc",
  flamingo: "#f2cdcd",
  pink: "#f5c2e7",
  mauve: "#cba6f7",
  red: "#f38ba8",
  maroon: "#eba0ac",
  peach: "#fab387",
  yellow: "#f9e2af",
  green: "#a6e3a1",
  teal: "#94e2d5",
  sky: "#89dceb",
  sapphire: "#74c7ec",
  blue: "#89b4fa",
  lavender: "#b4befe",
  text: "#cdd6f4",
  subtext1: "#bac2de",
  subtext0: "#a6adc8",
  overlay2: "#9399b2",
  overlay1: "#7f849c",
  overlay0: "#6c7086",
  surface2: "#585b70",
  surface1: "#45475a",
  surface0: "#313244",
  base: "#1e1e2e",
  mantle: "#181825",
  crust: "#11111b"
});

const fontStack = '"JetBrains Mono NL", "Maple Mono", "Cascadia Code", "Iosevka", Consolas, Menlo, monospace';
const heavyShadow = "0px 30px 50px rgba(17, 17, 27, 0.8)"; // crust shadow depth
const cardShadow = "1px 3px 5px rgba(17, 17, 27, 0.6)";
const contrastBorderColor = mochaPalette.sapphire; // accent used for framing floating windows
const focusBorderColor = mochaPalette.lavender; // accent reserved for focused items
const hoverBackgroundColor = mochaPalette.surface1; // subtle but higher contrast hover state
const subtleDividerColor = `rgba(148, 226, 213, 0.35)`; // teal translucent for separators
const softBackdrop = "rgba(17, 17, 27, 0.65)"; // glassy overlay backdrop

const baseHintStyles = [
  "font-size: 8pt",
  `font-family: ${fontStack}`,
  "padding: 0.5px 2px",
  `border: solid 0.5px ${mochaPalette.crust}`,
  `color: ${mochaPalette.base} !important`,
  "border-radius: 5px",
  `box-shadow: 3px 3px 5px rgba(17, 17, 27, 0.6)`
];

const hintStyle = (extra) => `${[...baseHintStyles, ...extra].join("; ")};`;

api.Hints.style(
  hintStyle([`background: ${mochaPalette.yellow} !important`])
);

api.Hints.style(
  hintStyle(["background: #ffffff !important", "font-weight: 600"]),
  "text"
);

api.Hints.style(
  hintStyle([
    `background: ${mochaPalette.yellow} !important`,
    `color: ${mochaPalette.crust} !important`,
    "border-width: 1px",
  ]),
  "active"
);


const themeCSS = `
  .sk_theme {
    background: ${mochaPalette.base};
    color: ${mochaPalette.text};
    font-family: ${fontStack};
    font-size: 10pt;
    --sk-bg-base: ${mochaPalette.base};
    --sk-bg-elevated: ${mochaPalette.mantle};
    --sk-bg-popover: ${mochaPalette.surface0};
    --sk-border-strong: ${contrastBorderColor};
    --sk-border-focus: ${focusBorderColor};
    --sk-text-primary: ${mochaPalette.text};
    --sk-text-muted: ${mochaPalette.subtext0};
    --sk-text-accent: ${mochaPalette.yellow};
    --sk-shadow-soft: ${cardShadow};
    --sk-shadow-strong: ${heavyShadow};
    --sk-divider: ${subtleDividerColor};
  }

  .sk_theme input,
  .sk_theme textarea,
  .sk_theme select,
  .sk_theme button {
    color: ${mochaPalette.text};
    background: ${mochaPalette.surface0};
    border: 1px solid ${mochaPalette.surface2};
    outline: none;
    border-radius: 8px;
    transition: border-color 0.2s ease, box-shadow 0.2s ease;
  }

  .sk_theme button,
  .sk_theme select {
    cursor: pointer;
  }

  .sk_theme input:focus,
  .sk_theme textarea:focus,
  .sk_theme select:focus,
  .sk_theme button:focus {
    border-color: ${focusBorderColor};
    box-shadow: 0 0 0 2px rgba(196, 167, 231, 0.35);
  }

  .sk_theme .url { color: ${mochaPalette.blue}; }
  .sk_theme .annotation { color: ${mochaPalette.rosewater}; }
  .sk_theme .feature_name,
  .sk_theme .prompt,
  .sk_theme .resultPage { color: ${mochaPalette.text}; }
  .sk_theme .separator { color: ${mochaPalette.surface2}; }
  .sk_theme .sk-separator { border-color: ${subtleDividerColor}; }

  .sk_theme a {
    color: ${mochaPalette.sky};
    transition: color 0.2s ease;
  }

  .sk_theme a:hover,
  .sk_theme a:focus {
    color: ${mochaPalette.teal};
  }

  .sk_theme .title,
  .sk_theme .subtitle,
  .sk_theme .bookmark,
  .sk_theme .status {
    color: ${mochaPalette.text};
  }

  .sk_theme .error,
  .sk_theme .sk_warning,
  .sk_theme .notification-error { color: ${mochaPalette.red}; }
  .sk_theme .success,
  .sk_theme .notification-success { color: ${mochaPalette.green}; }
  .sk_theme .info,
  .sk_theme .notification-info { color: ${mochaPalette.sky}; }

  .sk_theme kbd {
    background: ${mochaPalette.surface1};
    color: ${mochaPalette.text};
    border: 1px solid ${mochaPalette.surface2};
    border-radius: 6px;
    box-shadow: inset 0 -1px 0 rgba(17, 17, 27, 0.45);
    padding: 2px 5px;
  }

  .sk_theme table {
    width: 100%;
    border-collapse: collapse;
    background: ${softBackdrop};
    color: ${mochaPalette.text};
    box-shadow: ${cardShadow};
    border: 1px solid ${mochaPalette.surface2};
    border-radius: 10px;
    overflow: hidden;
  }

  .sk_theme thead {
    background: ${mochaPalette.surface1};
    color: ${mochaPalette.text};
  }

  .sk_theme tbody tr:nth-child(even) {
    background: rgba(49, 50, 68, 0.55);
  }

  .sk_theme th,
  .sk_theme td {
    border-bottom: 1px solid ${mochaPalette.surface2};
    padding: 6px 12px;
  }

  .sk_theme tbody tr:hover {
    background: ${hoverBackgroundColor};
  }

  .sk_theme .frame { background: ${mochaPalette.surface0}; }
  .sk_theme .omnibar_highlight { color: ${mochaPalette.yellow}; }
  .sk_theme .omnibar_visitcount,
  .sk_theme .omnibar_timestamp { color: ${mochaPalette.teal}; }

  .sk_theme .omnibar_folder {
    color: ${mochaPalette.text};
    border: 1px solid ${contrastBorderColor};
    border-radius: 8px;
    background: ${mochaPalette.mantle};
    box-shadow: ${cardShadow};
    padding: 2px 6px;
  }

  .sk_theme .omnibar_timestamp {
    background: ${mochaPalette.surface0};
    border: 1px solid ${contrastBorderColor};
    border-radius: 8px;
    box-shadow: ${cardShadow};
    padding: 2px 6px;
  }

  /* === Omnibar layout === */
  #sk_omnibar {
    overflow: hidden;
    position: fixed;
    width: 60%;
    max-height: 80%;
    left: 20%;
    top: auto;
    text-align: left;
    box-shadow: ${heavyShadow};
    z-index: 2147483000;
    border: 2px solid ${contrastBorderColor};
    border-radius: 14px;
    background: ${softBackdrop};
    backdrop-filter: blur(12px);
  }

  .sk_omnibar_middle { top: 15%; }
  .sk_omnibar_middle,
  .sk_omnibar_bottom { border-radius: 14px; }
  .sk_omnibar_bottom { bottom: 0; border-radius: 14px 14px 0 0; }

  #sk_omnibar span.omnibar_highlight { text-shadow: 0 0 0.01em; }

  #sk_omnibarSearchArea,
  .sk_omnibar_middle #sk_omnibarSearchArea,
  .sk_omnibar_bottom #sk_omnibarSearchArea {
    display: flex;
    align-items: center;
    border-bottom: none;
  }

  .sk_omnibar_middle #sk_omnibarSearchArea { margin: 0.5rem 1rem; }
  .sk_omnibar_bottom #sk_omnibarSearchArea { margin: 0.2rem 1rem; }

  #sk_omnibarSearchArea .prompt,
  #sk_omnibarSearchArea .resultPage {
    display: inline-block;
    font-size: 12pt;
    font-style: italic;
    width: auto;
  }

  #sk_omnibarSearchArea > input {
    width: 100%;
    flex: 1;
    font-size: 20px;
    padding: 0 0 0 0.5rem;
    margin-bottom: 0;
    color: ${mochaPalette.text};
    background: transparent;
  }

  #sk_omnibarSearchResult {
    max-height: 60vh;
    overflow: hidden;
    margin: 0;
  }

  #sk_omnibarSearchResult:empty { display: none; }
  #sk_omnibarSearchResult > ul { padding: 1em; }

  #sk_omnibarSearchResult > ul > li {
    margin-block: 0.5rem;
    padding-left: 0.4rem;
    display: block;
    max-height: 600px;
    overflow-x: hidden;
    overflow-y: auto;
    border: 1px solid transparent;
    border-radius: 10px;
    transition: background 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease;
  }

  .sk_theme #sk_omnibarSearchResult > ul > li:nth-child(odd) {
    background: ${softBackdrop};
  }

  .sk_theme #sk_omnibarSearchResult > ul > li:hover {
    background: ${hoverBackgroundColor};
    border-color: ${contrastBorderColor};
    box-shadow: ${cardShadow};
  }

  .sk_theme #sk_omnibarSearchResult > ul > li.focused {
    background: ${mochaPalette.mantle};
    border-radius: 12px;
    position: relative;
    box-shadow: ${heavyShadow};
    border: 2px solid ${focusBorderColor};
  }

  .sk_theme #sk_omnibarSearchResult > ul > li.window {
    border: 2px solid ${contrastBorderColor};
    border-radius: 10px;
    margin: 4px 0;
  }

  .sk_theme #sk_omnibarSearchResult > ul > li.window.focused {
    border: 2px solid ${focusBorderColor};
  }

  #sk_omnibarSearchResult li div.title {
    text-align: left;
    max-width: 100%;
    white-space: nowrap;
    overflow: auto;
  }

  #sk_omnibarSearchResult li div.url {
    font-weight: normal;
    white-space: nowrap;
    color: ${mochaPalette.subtext0};
  }

  #sk_omnibarSearchResult li span.annotation { float: right; }

  .sk_theme div.table { display: table; }
  .sk_theme div.table > * {
    vertical-align: middle;
    display: table-cell;
  }

  .sk_theme #sk_omnibarSearchResult .tab_in_window {
    display: inline-block;
    padding: 5px;
    margin: 5px;
    box-shadow: 0px 2px 10px rgba(17, 17, 27, 0.45);
    background: ${mochaPalette.mantle};
    border-radius: 6px;
  }

  /* === Tabs HUD === */
  #sk_tabs {
    position: fixed;
    top: 0;
    left: 0;
    overflow: auto;
    z-index: 2147483000;
    margin-left: 1rem;
    margin-top: 1.5rem;
    padding: 10px 0;
    background-color: ${softBackdrop};
    border: 2px solid ${contrastBorderColor};
    border-radius: 18px;
    box-shadow: ${heavyShadow};
    backdrop-filter: blur(16px);
  }

  #sk_tabs .sk_tab_group {
    display: flex;
    flex-direction: column;
    gap: 0.4rem;
    padding: 0.35rem 0.65rem;
    border-radius: 12px;
    transition: background 0.2s ease;
  }

  #sk_tabs .sk_tab_group:hover {
    background: rgba(69, 71, 90, 0.45);
  }

  #sk_tabs .sk_tab_group_header {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 0.4rem;
  }

  #sk_tabs .sk_tab_group_controls {
    margin-left: auto;
    display: flex;
    gap: 0.35rem;
    align-items: center;
  }

  #sk_tabs .sk_tab_group_toggle {
    background: ${mochaPalette.surface1};
    color: ${mochaPalette.text};
    border: 1px solid ${mochaPalette.surface2};
    border-radius: 999px;
    padding: 2px 10px;
    font-size: 9pt;
    font-family: ${fontStack};
    cursor: pointer;
    transition: border-color 0.2s ease, background 0.2s ease, color 0.2s ease;
  }

  #sk_tabs .sk_tab_group_toggle:hover,
  #sk_tabs .sk_tab_group_toggle:focus-visible {
    background: ${hoverBackgroundColor};
    border-color: ${focusBorderColor};
    color: ${mochaPalette.yellow};
  }

  #sk_tabs .sk_tab_group:not(.catppuccin-expanded) .sk_tab_group_details {
    display: none;
  }

  #sk_tabs .sk_tab_group.catppuccin-expanded .sk_tab_group_details {
    display: block;
  }

  #sk_tabs div.sk_tab {
    vertical-align: bottom;
    justify-items: center;
    background: ${mochaPalette.base};
    margin: 0;
    border-top: 0;
    box-shadow: none !important;
    border: 1px solid transparent;
    border-radius: 12px;
    transition: background 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease;
  }

  #sk_tabs div.sk_tab:hover {
    background: ${hoverBackgroundColor};
    border-color: ${contrastBorderColor};
  }

  #sk_tabs div.sk_tab:not(:has(.sk_tab_hint)) {
    background-color: ${mochaPalette.mantle} !important;
    box-shadow: ${heavyShadow} !important;
    border: 2px solid ${focusBorderColor};
    border-radius: 20px;
    position: relative;
    z-index: 1;
    margin: 0 0.7rem 0 1.8rem;
  }

  #sk_tabs div.sk_tab.active,
  #sk_tabs div.sk_tab:focus-within {
    border-color: ${focusBorderColor};
    box-shadow: ${heavyShadow} !important;
    background: ${mochaPalette.mantle};
  }

  #sk_tabs div.sk_tab_title {
    display: inline-block;
    vertical-align: middle;
    font-size: 10pt;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
    padding-left: 5px;
    color: ${mochaPalette.text};
  }

  #sk_tabs div.sk_tab_hint,
  #sk_tabs div.sk_tab_group div.sk_tab_hint {
    border: 0.5px solid ${mochaPalette.crust};
    color: ${mochaPalette.base};
    background: ${mochaPalette.yellow};
    font-family: ${fontStack};
    font-size: 8pt;
    padding: 0.5px 2px;
    border-radius: 5px;
    box-shadow: 3px 3px 5px rgba(17, 17, 27, 0.6);
    display: inline-flex;
    align-items: center;
    justify-content: center;
    flex: 0 0 auto;
    max-width: max-content;
    min-width: 0;
    white-space: nowrap;
  }

  #sk_tabs.vertical div.sk_tab_hint {
    position: inherit;
    left: 8pt;
    margin-top: 3px;
  }

  #sk_tabs.vertical div.sk_tab_wrap {
    display: inline-block;
    margin-left: 0;
    margin-top: 0;
    padding-left: 15px;
  }

  #sk_tabs.vertical div.sk_tab_title {
    min-width: 100pt;
    max-width: 20vw;
  }

  /* === Overlays / Popups === */
  #sk_usage,
  #sk_popup {
    overflow: hidden auto;
    position: fixed;
    width: 80%;
    max-height: 80%;
    top: 10%;
    left: 10%;
    text-align: left;
    padding: 1rem;
    border: 2px solid ${contrastBorderColor};
    border-radius: 14px;
    background: ${softBackdrop};
    color: ${mochaPalette.text};
    box-shadow: ${heavyShadow};
    scrollbar-width: thin;
    scrollbar-color: ${mochaPalette.surface2} ${mochaPalette.surface0};
    backdrop-filter: blur(16px) saturate(120%);
  }

  #sk_usage::-webkit-scrollbar,
  #sk_popup::-webkit-scrollbar {
    width: 10px;
  }

  #sk_usage::-webkit-scrollbar-track,
  #sk_popup::-webkit-scrollbar-track {
    background: ${mochaPalette.surface0};
    border-radius: 10px;
  }

  #sk_usage::-webkit-scrollbar-thumb,
  #sk_popup::-webkit-scrollbar-thumb {
    background: ${mochaPalette.surface2};
    border-radius: 10px;
    border: 2px solid ${mochaPalette.surface0};
  }

  #sk_usage::-webkit-scrollbar-thumb:hover,
  #sk_popup::-webkit-scrollbar-thumb:hover {
    background: ${mochaPalette.overlay1};
  }

  #sk_popup img { width: 100%; }

  #sk_usage > div { display: inline-block; vertical-align: top; }
  #sk_usage * { font-size: 10pt; }
  #sk_usage .kbd-span { width: 80px; text-align: right; display: inline-block; }
  #sk_usage .feature_name { text-align: center; padding-bottom: 4px; }
  #sk_usage .feature_name > span { border-bottom: 2px solid ${mochaPalette.surface2}; }
  #sk_usage span.annotation { padding-left: 32px; line-height: 22px; }

  #sk_usage h2,
  #sk_popup h2,
  #sk_popup h3 {
    margin-top: 0;
    color: ${mochaPalette.lavender};
    border-bottom: 1px solid ${subtleDividerColor};
    padding-bottom: 0.35rem;
    letter-spacing: 0.04em;
    text-transform: uppercase;
  }

  /* === Vim-style editor overlay === */
  #sk_editor {
    background: ${mochaPalette.base};
    color: #000000;
    border: 2px solid ${contrastBorderColor};
    border-radius: 14px;
    box-shadow: ${heavyShadow};
  }

  #sk_editor .ace_scroller,
  #sk_editor .ace_content {
    background: ${mochaPalette.base};
    color: ${mochaPalette.text};
  }

  /* Vim confirm/status notifications (e.g. "Quit anyway? Y/n") */
  #sk_editor .cm-vim-message {
    color: ${mochaPalette.text} !important;
    background: ${mochaPalette.surface1} !important;
    border: 1px solid ${contrastBorderColor} !important;
    border-radius: 10px !important;
    box-shadow: 0 15px 30px rgba(17, 17, 27, 0.65) !important;
    padding: 6px 10px !important;
    text-shadow: none !important;
  }

  #sk_editor .cm-vim-message > * {
    color: inherit !important;
  }

  #sk_editor .cm-vim-message .CodeMirror-dialog-button,
  #sk_editor .cm-vim-message .CodeMirror-dialog span {
    font-weight: 600;
    color: ${mochaPalette.peach} !important;
  }

  #sk_editor .CodeMirror-dialog {
    background: ${mochaPalette.mantle};
    color: ${mochaPalette.text};
    border: 1px solid ${contrastBorderColor};
    border-radius: 8px;
    box-shadow: ${cardShadow};
    padding: 6px 8px;
  }

  #sk_editor .CodeMirror-dialog input {
    background: ${mochaPalette.surface0};
    color: ${mochaPalette.text};
    border: 1px solid ${mochaPalette.surface2};
    border-radius: 6px;
    padding: 4px 6px;
  }

  #sk_editor .CodeMirror-gutters {
    background: ${mochaPalette.surface0};
    color: ${mochaPalette.overlay1};
    border-right: 1px solid ${mochaPalette.surface2};
  }

  #sk_editor .CodeMirror-activeline-background {
    background: rgba(49, 50, 68, 0.55);
  }

  #sk_editor .CodeMirror-cursor {
    border-left: 2px solid ${mochaPalette.rosewater};
  }

  #sk_editor .CodeMirror-selected {
    background: rgba(137, 180, 250, 0.35);
  }

  #sk_editor .ace_gutter {
    background: ${mochaPalette.surface0};
    color: ${mochaPalette.overlay1};
  }

  #sk_editor .ace_gutter-active-line {
    background: rgba(69, 71, 90, 0.65);
    color: ${mochaPalette.text};
  }

  #sk_editor .ace_marker-layer .ace_active-line {
    background: rgba(49, 50, 68, 0.55);
  }

  #sk_editor .ace_marker-layer .ace_selection {
    background: rgba(137, 180, 250, 0.35);
  }

  #sk_editor .ace_marker-layer .ace_selected-word {
    border: 1px solid ${mochaPalette.blue};
    background: rgba(137, 180, 250, 0.45);
  }

  #sk_editor .ace_cursor,
  #sk_editor .ace_hidden-cursors .ace_cursor {
    color: ${mochaPalette.rosewater};
  }

  #sk_editor .ace_print-margin {
    width: 1px;
    background: ${mochaPalette.surface2};
  }

  #sk_editor .ace_tooltip {
    background: ${mochaPalette.surface0};
    color: ${mochaPalette.text};
    border: 1px solid ${contrastBorderColor};
    border-radius: 8px;
    box-shadow: ${cardShadow};
  }

  #sk_editor .ace_search {
    background: ${mochaPalette.mantle};
    color: ${mochaPalette.text};
    border: 1px solid ${contrastBorderColor};
    border-radius: 10px;
    box-shadow: ${cardShadow};
  }

  #sk_editor .ace_search_form,
  #sk_editor .ace_replace_form {
    border-bottom: 1px solid ${subtleDividerColor};
  }

  #sk_editor .ace_search_field {
    background: ${mochaPalette.surface0};
    color: ${mochaPalette.text};
    border: 1px solid ${mochaPalette.surface2};
    border-radius: 6px;
  }

  #sk_editor .ace_button {
    background: ${mochaPalette.surface1};
    color: ${mochaPalette.text};
    border: 1px solid ${mochaPalette.surface2};
    border-radius: 6px;
  }

  #sk_editor .ace_button:hover,
  #sk_editor .ace_button:focus {
    background: ${hoverBackgroundColor};
    border-color: ${focusBorderColor};
  }

  /* === Keystroke HUD === */
  #sk_keystroke {
    padding: 6px;
    position: fixed;
    bottom: 0;
    right: 0;
    z-index: 2147483000;
    margin: 0 1rem 1rem 0;
    background: ${softBackdrop};
    color: ${mochaPalette.text};
    border: 2px solid ${contrastBorderColor};
    border-radius: 12px;
    box-shadow: ${heavyShadow};
    backdrop-filter: blur(12px);
  }

  #sk_keystroke.expandRichHints .kbd-span kbd {
    color: ${mochaPalette.red};
  }

  #sk_keystroke.expandRichHints .kbd-span kbd > .candidates {
    color: ${mochaPalette.text};
  }

  /* === Status === */
  #sk_status {
    position: fixed;
    bottom: 0;
    right: 39%;
    z-index: 2147483000;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    padding: 8px 12px 6px;
    width: auto;
    max-width: 22rem;
    min-width: 12rem;
    margin-bottom: 1rem;
    text-align: center;
    background: ${softBackdrop};
    color: ${mochaPalette.text};
    border: 2px solid ${contrastBorderColor};
    border-radius: 12px;
    box-shadow: 0px 20px 40px 2px rgba(17, 17, 27, 1);
    backdrop-filter: blur(12px);
  }

  #sk_find {
    font-size: 10pt;
    font-weight: bold;
    text-align: left;
    padding: 0.35rem 0.75rem;
    flex: 1 1 14rem;
    max-width: 16rem;
    min-width: 10rem;
    margin: 0;
  }

  #sk_status span:empty {
    display: none;
  }

  #sk_status span[style*="border-right: 1px solid rgb(153, 153, 153);"] {
    display: none;
  }

  #sk_notice,
  #sk_prompt,
  #sk_clipboard,
  #sk_confirm,
  #sk_bookmark {
    position: fixed;
    z-index: 2147483001;
    padding: 10px 14px;
    background: ${softBackdrop};
    color: ${mochaPalette.text};
    border: 1px solid ${contrastBorderColor};
    border-radius: 12px;
    box-shadow: ${heavyShadow};
    backdrop-filter: blur(14px);
  }

  #sk_notice .sk_notice_action,
  #sk_confirm .sk_notice_action {
    margin-top: 0.5rem;
    display: flex;
    gap: 0.5rem;
    justify-content: flex-end;
  }

  #sk_notice button,
  #sk_prompt button,
  #sk_clipboard button,
  #sk_confirm button,
  #sk_bookmark button {
    background: ${mochaPalette.surface1};
    color: ${mochaPalette.text};
    border: 1px solid ${mochaPalette.surface2};
    border-radius: 8px;
    padding: 4px 10px;
  }

  #sk_notice button:hover,
  #sk_prompt button:hover,
  #sk_clipboard button:hover,
  #sk_confirm button:hover,
  #sk_bookmark button:hover {
    background: ${hoverBackgroundColor};
    border-color: ${focusBorderColor};
  }

  #sk_prompt textarea,
  #sk_clipboard textarea,
  #sk_bookmark textarea {
    min-height: 6rem;
  }

  /* === Banner === */
  #sk_banner {
    padding: 0.5rem;
    position: fixed;
    left: 10%;
    top: -3rem;
    width: 80%;
    z-index: 2147483000;
    border-radius: 8px;
    border: 2px solid ${mochaPalette.rosewater};
    color: ${mochaPalette.yellow};
    text-align: center;
    background: ${mochaPalette.base};
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
    box-shadow: ${cardShadow};
    backdrop-filter: blur(12px);
  }

  /* === Bubble / Tooltip === */
  #sk_bubble {
    position: absolute;
    padding: 9px;
    border: 2px solid ${contrastBorderColor};
    border-radius: 10px;
    box-shadow: 0 0 20px rgba(17, 17, 27, 0.45);
    color: ${mochaPalette.text};
    background-color: ${softBackdrop};
    z-index: 2147483000;
    font-size: 14px;
    backdrop-filter: blur(10px);
  }

  #sk_bubble .sk_bubble_content {
    overflow-y: scroll;
    background-size: 3px 100%;
    background-position: 100%;
    background-repeat: no-repeat;
  }

  .sk_scroller_indicator_top { background-image: linear-gradient(${softBackdrop}, transparent); }
  .sk_scroller_indicator_middle { background-image: linear-gradient(transparent, ${softBackdrop}, transparent); }
  .sk_scroller_indicator_bottom { background-image: linear-gradient(transparent, ${softBackdrop}); }
  #sk_bubble * { color: ${mochaPalette.text} !important; }

  div.sk_arrow > div:nth-of-type(1) {
    left: 0;
    position: absolute;
    width: 0;
    border-left: 12px solid transparent;
    border-right: 12px solid transparent;
    background: transparent;
  }

  div.sk_arrow[dir=down] > div:nth-of-type(1) { border-top: 12px solid ${mochaPalette.surface2}; }
  div.sk_arrow[dir=up] > div:nth-of-type(1) { border-bottom: 12px solid ${mochaPalette.surface2}; }

  div.sk_arrow > div:nth-of-type(2) {
    left: 2px;
    position: absolute;
    width: 0;
    border-left: 10px solid transparent;
    border-right: 10px solid transparent;
    background: transparent;
  }

  div.sk_arrow[dir=down] > div:nth-of-type(2) { border-top: 10px solid ${mochaPalette.text}; }
  div.sk_arrow[dir=up] > div:nth-of-type(2) { top: 2px; border-bottom: 10px solid ${mochaPalette.text}; }

  /* === Editor / NVim overlay === */
  #sk_nvim {
    position: fixed;
    top: 10%;
    left: 10%;
    width: 80%;
    height: 30%;
    border: 2px solid ${contrastBorderColor};
    border-radius: 14px;
    background: ${softBackdrop};
    box-shadow: ${heavyShadow};
    backdrop-filter: blur(12px);
  }

  /* === Responsive tweaks === */
  @media only screen and (max-width: 767px) {
    #sk_omnibar { width: 100%; left: 0; }
    #sk_omnibarSearchResult { max-height: 50vh; overflow: scroll; }
    .sk_omnibar_bottom #sk_omnibarSearchArea { margin: 0; padding: 0.2rem; }
  }
`;

settings.theme = themeCSS;

/**
 * Collapse tab group details by default and add an explicit expansion toggle.
 */
(function enableCatppuccinGroupToggles() {
  if (typeof document === "undefined") {
    return;
  }

  const tabsContainerId = "sk_tabs";
  const processedAttr = "data-catppuccin-group-enhanced";

  const updateToggleLabel = (button, group) => {
    const details = group.querySelector(".sk_tab_group_details");
    const tabCount = details ? details.querySelectorAll(".sk_tab").length : 0;
    const expanded = group.classList.contains("catppuccin-expanded");
    const verb = expanded ? "Hide" : "Show";
    const suffix = tabCount ? ` (${tabCount})` : "";
    button.textContent = `${verb} tabs${suffix}`;
    button.setAttribute("aria-expanded", expanded ? "true" : "false");
  };

  const enhanceGroup = (group) => {
    if (group.getAttribute(processedAttr) === "true") {
      return;
    }

    const details = group.querySelector(".sk_tab_group_details");
    if (!details) {
      return;
    }

    group.setAttribute(processedAttr, "true");
    group.classList.remove("catppuccin-expanded");

    const header = group.querySelector(".sk_tab_group_header") || group;
    let controls = header.querySelector(".sk_tab_group_controls");
    if (!controls) {
      controls = document.createElement("div");
      controls.className = "sk_tab_group_controls";
      header.append(controls);
    }

    const toggleButton = document.createElement("button");
    toggleButton.type = "button";
    toggleButton.className = "sk_tab_group_toggle";
    toggleButton.addEventListener("click", (event) => {
      event.stopPropagation();
      event.preventDefault();
      group.classList.toggle("catppuccin-expanded");
      updateToggleLabel(toggleButton, group);
    });

    controls.append(toggleButton);
    updateToggleLabel(toggleButton, group);
  };

  const processGroups = () => {
    const tabsContainer = document.getElementById(tabsContainerId);
    if (!tabsContainer) {
      return;
    }
    tabsContainer.querySelectorAll(".sk_tab_group").forEach(enhanceGroup);
  };

  const waitForTabsContainer = () => {
    const tabsContainer = document.getElementById(tabsContainerId);
    if (!tabsContainer) {
      window.setTimeout(waitForTabsContainer, 250);
      return;
    }

    const observer = new MutationObserver((mutations) => {
      if (mutations.some((mutation) => mutation.addedNodes.length > 0)) {
        processGroups();
      }
    });
    observer.observe(tabsContainer, { childList: true, subtree: true });
    processGroups();
  };

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", waitForTabsContainer, { once: true });
  } else {
    waitForTabsContainer();
  }
})();

