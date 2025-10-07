# WiFi Diagnostics Script for RHEL-based Systems


This repository contains a simple **bash script** that helps you diagnose and troubleshoot WiFi issues on **RHEL and its alternatives** (CentOS, Rocky, AlmaLinux, Oracle Linux, etc.).  
It checks the WiFi interface, driver, kernel module, and gives suggestions based on the detected hardware vendor.

## 📋 Features
✅ Check WiFi interfaces status  
✅ Check WiFi radio (enabled/disabled)  
✅ Detect hardware/software blocks with **rfkill**  
✅ List available WiFi networks  
✅ Detect WiFi hardware and drivers with **lspci**  
✅ Check loaded kernel modules  
✅ Provide **driver suggestions** based on vendor (Intel, Broadcom, Realtek, Qualcomm, MediaTek)  
✅ General troubleshooting tips

------

 ## 🚀 Usage

Clone this repository and run the script:

- git clone https://github.com/dzsolly/wifi-diag-rhel.git
- cd wifi-diag-rhel
- chmod +x wifi-diag-rhel.sh
- ./wifi-diag-rhel.sh

------

## 📸 Example Output

```bash
=== WiFi Diagnostics - RHEL-based system ===

🔹 Step 1: Interfaces status
wlp3s0  wifi  disconnected  --

🔹 Step 2: WiFi radio
enabled

🔹 Step 3: Hardware/Software block
0: phy0: Wireless LAN
    Soft blocked: no
    Hard blocked: no

🔹 Step 4: Available WiFi networks
SSID             MODE   CHAN  RATE   SIGNAL  BARS  SECURITY
MyWiFiNetwork    Infra  6     54 Mbit/s  80   ▂▄▆█  WPA2

🔹 Step 5: WiFi hardware and driver
02:00.0 Network controller: Broadcom BCM43142 802.11b/g/n
    Subsystem: Lenovo Device 0611
    Kernel driver in use: wl

🔹 Step 6: Loaded WiFi kernel modules
wl                123456  0

🔹 Step 7: Driver suggestion


⚠️ Broadcom card detected → try drivers: wl (proprietary) or b43/brcmfmac (open source).
   On RHEL-based systems: sudo dnf install akmod-wl broadcom-wl

💡 General Suggestions:
- If the module is not loaded, try: sudo modprobe <module>
- If WiFi is blocked: sudo rfkill unblock wifi
- If no driver is found, install the proper package from EPEL or RPM Fusion.
- Ensure the interface is managed: nmcli device set <interface> managed yes
- Verify that NetworkManager is installed: sudo dnf install NetworkManager

✅ Diagnostics finished.
```

------

## 📦 Supported Vendors

| Vendor       | Recommended Drivers                         |
| ------------ | ------------------------------------------- |
| **Intel**    | `iwlwifi` (included by default)             |
| **Broadcom** | `wl`, `b43`, `brcmsmac`, `brcmfmac`         |
| **Realtek**  | `rtl8187`, `rtl8192cu`, `rtl8xxxu`, `rtw88` |
| **Qualcomm** | `ath9k`, `ath10k`, `ath11k`                 |
| **MediaTek** | `mt76`, `rt2800pci`, `rt2800usb`            |

------

## 📝 License

This project is released under the MIT License.

## 📘 Related Guide

If you’re troubleshooting issues with the Ralink MT7601U USB Wi-Fi adapter on RHEL 8 or compatible systems (Rocky, Alma, Oracle), check out my detailed write-up:

### 📘 [MT7601U Survival Guide: Fixing USB Wi-Fi on RHEL 8](./MT7601U%20Survival%20Guide%3A%20Fixing%20USB%20Wi-Fi%20on%20RHEL%208.md)


This document walks through the full process I used to get the adapter working — from detecting the device and checking driver status to verifying nmcli output and handling common “unavailable” states.
It’s based on real troubleshooting steps, not just theory, so it’s worth a read before diving into your own setup.
