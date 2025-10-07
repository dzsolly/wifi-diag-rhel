# MT7601U Survival Guide: Fixing USB Wi-Fi on RHEL 8

This guide is based on my own experience troubleshooting USB Wi-Fi connectivity issues on **Rocky Linux 8**.  
I originally wrote a Wi-Fi setup script to automate basic configuration, but I later discovered that some adapters — especially the **Ralink MT7601U** — require manual intervention to get them fully operational.  

I decided to document the entire process here so others can review the steps, understand common pitfalls, and fix similar problems on RHEL-based systems.  
If you're working with a USB Wi-Fi device that shows as `down`, `unavailable`, or blocked by `RF-kill`, it’s worth reading through this walkthrough before giving up.

## 🧩 1. Verify that the system detects your USB Wi-Fi adapter

Run:
```bash
lsusb
```

If the device is listed (for example), then the hardware is recognized by the system.

```bash
Bus 001 Device 004: ID 148f:7601 Ralink Technology, Corp. MT7601U Wireless Adapter
```

## ⚙️ 2. Check the network interfaces
