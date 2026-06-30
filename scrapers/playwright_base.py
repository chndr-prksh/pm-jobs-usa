"""
Shared Playwright browser context for CF-protected / JS-rendered career sites.
One browser instance is reused across all Playwright-based scrapers per run.
"""

from playwright.sync_api import sync_playwright, Browser, BrowserContext
import json

_playwright = None
_browser: Browser = None
_context: BrowserContext = None


def get_context() -> BrowserContext:
    global _playwright, _browser, _context
    if _context is None:
        _playwright = sync_playwright().start()
        _browser = _playwright.chromium.launch(headless=True)
        _context = _browser.new_context(
            user_agent=(
                "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
                "AppleWebKit/537.36 (KHTML, like Gecko) "
                "Chrome/124.0.0.0 Safari/537.36"
            ),
            viewport={"width": 1280, "height": 800},
        )
    return _context


def close():
    global _playwright, _browser, _context
    if _browser:
        _browser.close()
    if _playwright:
        _playwright.stop()
    _browser = None
    _context = None
    _playwright = None


def fetch_json(url: str, js_fetch_options: dict = None):
    """
    Open url in a real browser (solves Cloudflare), then call the same URL
    (or a different API url) via in-page fetch() to get JSON.

    js_fetch_options keys: api_url, method, body, headers
    """
    ctx = get_context()
    page = ctx.new_page()
    try:
        page.goto(url, wait_until="domcontentloaded", timeout=30000)

        api_url = (js_fetch_options or {}).get("api_url", url)
        method = (js_fetch_options or {}).get("method", "GET")
        body = (js_fetch_options or {}).get("body")
        extra_headers = (js_fetch_options or {}).get("headers", {})

        result = page.evaluate(
            """async ({ apiUrl, method, body, extraHeaders }) => {
                const opts = { method, headers: { 'Accept': 'application/json', ...extraHeaders } };
                if (body) opts.body = JSON.stringify(body);
                const r = await fetch(apiUrl, opts);
                return await r.json();
            }""",
            {"apiUrl": api_url, "method": method, "body": body, "extraHeaders": extra_headers},
        )
        return result
    finally:
        page.close()
