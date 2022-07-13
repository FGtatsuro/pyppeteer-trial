import asyncio
import os

import pyppeteer

def options():
    opts = {
        'executablePath': os.environ.get('EXECUTABLE_PATH', '/usr/bin/chromium'),
    }

    headless = True
    if os.environ.get('HEADLESS', '').lower() == 'false':
        headless = False
    opts['headless'] = headless

    args = []

    no_sandbox = True
    if os.environ.get('NO_SANDBOX', '').lower() == 'false':
        no_sandbox = False
    if no_sandbox:
        args.append('--no-sandbox')

    opts['args'] = args

    return opts


async def main():
    browser = await pyppeteer.launch(options())
    page = await browser.newPage()
    await page.goto('https://example.com')
    await page.screenshot({'path': 'example.png'})
    await browser.close()


if __name__ == '__main__':
    asyncio.run(main())
