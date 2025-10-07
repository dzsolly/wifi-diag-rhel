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

Run:
```bash
ip link show
```

You should see a wireless interface such as, If the interface exists but shows state DOWN, it means the adapter is present but not yet activated.
```bash
5: wlp0s20u2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 ...
```

To manually bring it up:
```bash
sudo ip link set wlp0s20u2 up
```

If you see, → Continue to the next section.
```bash
RTNETLINK answers: Operation not possible due to RF-kill
```

## 📡 3. Resolve RF-Kill (radio disabled)

List the current RF-kill status:
```bash
rfkill list
```

Example output:
```bash
0: phy0: Wireless LAN
    Soft blocked: yes
    Hard blocked: no
```

- Soft blocked: software-level disable (can be fixed via command)
- Hard blocked: hardware switch or BIOS disables the radio

To unblock:
```bash
sudo rfkill unblock all
```

Then verify:
```bash
rfkill list
```

Re-enable Wi-Fi via NetworkManager:
```bash
sudo nmcli radio wifi on
```

If you see, repeat the unblock command and recheck BIOS or physical Wi-Fi toggle keys.
```bash
RTNETLINK answers: Operation not possible due to RF-kill
```

## 🔧 4. Check the adapter state via NetworkManager

Run:
```bash
nmcli
```

You might see something like, This indicates the Wi-Fi radio is software disabled.
```bash
wlp0s20u2: unavailable
        "Ralink MT7601U"
        wifi (mt7601u), E2:4A:8B:EF:71:E0, sw disabled, hw, mtu 1500
```
Enable it:
```bash
sudo nmcli radio wifi on
```

If still unavailable:
```bash
rfkill list
sudo rfkill unblock all
sudo nmcli radio wifi on
```

Then restart the interface:
```bash
sudo modprobe -r mt7601u
sudo modprobe mt7601u
sudo systemctl restart NetworkManager
```
