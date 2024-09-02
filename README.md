# Termux Setup on Android

## Prerequisites

Install the following packages from F-Droid:

- **Required:**
    - Termux
    - Termux:API
    - Termux:Boot
    - Termux:Widget
- **Optional (but recommended):**
    - Termux:Styling

## Run Setup

Copy & Paste the following snippet into your Termux terminal and run it:

```bash
curl -sS -o termux-install.sh https://raw.githubusercontent.com/marbetschar/termux/main/install.sh && \
    chmod +x termux-install.sh && \
    ./termux-install.sh && \
    rm -f termux-install.sh
```
