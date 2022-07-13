FROM python:3.10-bullseye AS builder

WORKDIR /opt/app

RUN pip install pyppeteer


FROM python:3.10-slim-bullseye AS runner

WORKDIR /opt/app

COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages

# Install Chromium manually (not using pyppeteer-install feature)
# There are several advantages of apt install.
#   1. Resolve native library dependencies.
#   2. Resolve architecture differences. (ex. Architecture of Docker on M1 Mac is ARM64)
#
# FYI:
#   - https://canercanbaz.dev/fix-node-js-puppeteer-docker-image-build-problem-on-m1-macs/
#   - https://solveforum.com/forums/threads/solved-puppeteer-on-docker-m1-mac-fails-to-open-new-page.469432/
RUN apt-get update \
	&& apt-get install -y chromium \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY main.py /opt/app

ENTRYPOINT ["python"]
CMD ["/opt/app/main.py"]
