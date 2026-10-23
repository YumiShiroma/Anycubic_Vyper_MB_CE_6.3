# Reproducible build environment for the Vyper CE firmware.
#
#   docker build -t vyper-ce .
#   docker run --rm -v "$PWD":/firmware -w /firmware vyper-ce \
#       bash scripts/build_all.sh LA_JD_IS
#
FROM python:3.11-slim-bookworm

RUN apt-get update \
 && apt-get install -y --no-install-recommends git ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir "platformio==6.2.0"

WORKDIR /firmware
CMD ["bash", "scripts/build_all.sh"]
