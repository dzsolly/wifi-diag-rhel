#!/bin/bash

echo "=== WiFi Diagnostics - RHEL-based system ==="
echo ""

# 1. List WiFi interfaces
echo "🔹 Step 1: Interfaces status"
nmcli device status | grep wifi
echo ""

# 2. Check WiFi radio status
echo "🔹 Step 2: WiFi radio"
nmcli radio wifi
echo ""

# 3. Check RFKill (soft/hard block)
echo "🔹 Step 3: Hardware/Software block"
rfkill list wifi
echo ""

# 4. List available WiFi networks
echo "🔹 Step 4: Available WiFi networks"
nmcli device wifi list
echo ""

# 5. Detect WiFi hardware and driver
echo "🔹 Step 5: WiFi hardware and driver"
WIFI_INFO=$(lspci -k | grep -iA3 network)
echo "$WIFI_INFO"
echo ""

# 6. Check loaded WiFi modules
echo "🔹 Step 6: Loaded WiFi kernel modules"
lsmod | grep -E 'wl|b43|brcm|iwlwifi|ath9k|ath10k|ath11k|rtl8187|rtl8192cu|rtl8xxxu|rtw88|mt76|rt2800pci|rt2800usb'
echo ""

# 7. Suggest driver based on vendor
echo "🔹 Step 7: Driver suggestion"
if echo "$WIFI_INFO" | grep -qi "Intel"; then
    echo "✅ Intel card detected → recommended driver: iwlwifi (usually included by default)."
elif echo "$WIFI_INFO" | grep -qi "Broadcom"; then
    echo "⚠️ Broadcom card detected → try drivers: wl (proprietary) or b43/brcmfmac (open source)."
    echo "   On RHEL-based systems: sudo dnf install akmod-wl broadcom-wl"
elif echo "$WIFI_INFO" | grep -qi "Realtek"; then
    echo "⚠️ Realtek card detected → common drivers: rtl8187, rtl8192cu, rtl8xxxu, rtw88."
elif echo "$WIFI_INFO" | grep -qi "Qualcomm"; then
    echo "✅ Qualcomm/Atheros card detected → recommended driver: ath9k, ath10k, or ath11k."
elif echo "$WIFI_INFO" | grep -qi "MediaTek\|Ralink"; then
    echo "✅ MediaTek/Ralink card detected → recommended driver: mt76 or rt2800 series."
else
    echo "❓ Could not detect a specific vendor. Please check manually."
fi
echo ""

# 8. General suggestions
echo "💡 General Suggestions:"
echo "- If the module is not loaded, try: sudo modprobe <module>"
echo "- If WiFi is blocked: sudo rfkill unblock wifi"
echo "- If no driver is found, install the proper package from EPEL or RPM Fusion."
echo "- Ensure the interface is managed: nmcli device set <interface> managed yes"
echo "- Verify that NetworkManager is installed: sudo dnf install NetworkManager"
echo ""
echo "✅ Diagnostics finished."
