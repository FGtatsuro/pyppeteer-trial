# pyppeteer-trial
Trial of pyppeteer

## Build

```bash
$ make docker/clean docker/build
```

## Run

```bash
$ make docker/rm docker/run
```

## Run on local (For Development)

```bash
$ pip3 install pyppeteer
```

```bash
$ EXECUTABLE_PATH='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' HEADLESS=false NO_SANDBOX=false python main.py
```
