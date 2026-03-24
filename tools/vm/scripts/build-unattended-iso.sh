#!/bin/bash
set -euo pipefail

LAB="$HOME/malware-lab"
WIN_ISO="$LAB/iso/Win10.iso"
VIRTIO_ISO="$LAB/iso/virtio-win.iso"
OUT_ISO="$LAB/iso/Win10-unattended.iso"
WORK="$LAB/iso-build"

if [ -f "$OUT_ISO" ]; then
    echo "Unattended ISO already exists at $OUT_ISO"
    exit 0
fi

echo "=== Building unattended Win10 32-bit ISO ==="

# Clean workspace
rm -rf "$WORK"
mkdir -p "$WORK"/{win,virtio}

# Mount and copy Win10 ISO
echo "Extracting Win10 ISO..."
sudo mount -o loop,ro "$WIN_ISO" /mnt
cp -a /mnt/. "$WORK/win/"
sudo umount /mnt
chmod -R u+w "$WORK/win"

# Mount virtio ISO and copy x86 drivers
echo "Extracting virtio drivers..."
sudo mount -o loop,ro "$VIRTIO_ISO" /mnt
mkdir -p "$WORK/win/virtio"
# Storage driver (viostor) - needed during install
cp -r /mnt/viostor/w10/x86/* "$WORK/win/virtio/"
# Network driver (NetKVM) - for later
cp -r /mnt/NetKVM/w10/x86/* "$WORK/win/virtio/" 2>/dev/null || true
# Balloon driver
cp -r /mnt/Balloon/w10/x86/* "$WORK/win/virtio/" 2>/dev/null || true
# VirtIO Serial (needed for our C2 channel)
cp -r /mnt/vioserial/w10/x86/* "$WORK/win/virtio/" 2>/dev/null || true
# Also copy the guest tools installer
cp /mnt/virtio-win-gt-x86.msi "$WORK/win/virtio/" 2>/dev/null || true
sudo umount /mnt

# Create autounattend.xml
cat > "$WORK/win/autounattend.xml" << 'XMLEOF'
<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
  <settings pass="windowsPE">
    <component name="Microsoft-Windows-International-Core-WinPE" processorArchitecture="x86" language="neutral" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State">
      <SetupUILanguage>
        <UILanguage>en-US</UILanguage>
      </SetupUILanguage>
      <InputLocale>en-US</InputLocale>
      <SystemLocale>en-US</SystemLocale>
      <UILanguage>en-US</UILanguage>
      <UserLocale>en-US</UserLocale>
    </component>
    <component name="Microsoft-Windows-Setup" processorArchitecture="x86" language="neutral" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State">
      <DiskConfiguration>
        <Disk wcm:action="add">
          <DiskID>0</DiskID>
          <WillWipeDisk>true</WillWipeDisk>
          <CreatePartitions>
            <CreatePartition wcm:action="add">
              <Order>1</Order>
              <Type>Primary</Type>
              <Extend>true</Extend>
            </CreatePartition>
          </CreatePartitions>
          <ModifyPartitions>
            <ModifyPartition wcm:action="add">
              <Order>1</Order>
              <PartitionID>1</PartitionID>
              <Format>NTFS</Format>
              <Label>Windows</Label>
              <Letter>C</Letter>
              <Active>true</Active>
            </ModifyPartition>
          </ModifyPartitions>
        </Disk>
      </DiskConfiguration>
      <ImageInstall>
        <OSImage>
          <InstallTo>
            <DiskID>0</DiskID>
            <PartitionID>1</PartitionID>
          </InstallTo>
          <InstallFrom>
            <MetaData wcm:action="add">
              <Key>/IMAGE/NAME</Key>
              <Value>Windows 10 Pro</Value>
            </MetaData>
          </InstallFrom>
        </OSImage>
      </ImageInstall>
      <UserData>
        <AcceptEula>true</AcceptEula>
        <ProductKey>
          <WillShowUI>Never</WillShowUI>
        </ProductKey>
      </UserData>
      <DriverPaths>
        <PathAndCredentials wcm:action="add" wcm:keyValue="1">
          <Path>virtio</Path>
        </PathAndCredentials>
      </DriverPaths>
    </component>
  </settings>
  <settings pass="oobeSystem">
    <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="x86" language="neutral" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State">
      <OOBE>
        <HideEULAPage>true</HideEULAPage>
        <HideLocalAccountScreen>true</HideLocalAccountScreen>
        <HideOnlineAccountScreens>true</HideOnlineAccountScreens>
        <HideWirelessSetupInOOBE>true</HideWirelessSetupInOOBE>
        <ProtectYourPC>3</ProtectYourPC>
        <NetworkLocation>Work</NetworkLocation>
      </OOBE>
      <UserAccounts>
        <LocalAccounts>
          <LocalAccount wcm:action="add">
            <Name>lab</Name>
            <Group>Administrators</Group>
            <Password>
              <Value>lab</Value>
              <PlainText>true</PlainText>
            </Password>
          </LocalAccount>
        </LocalAccounts>
      </UserAccounts>
      <AutoLogon>
        <Enabled>true</Enabled>
        <Username>lab</Username>
        <Password>
          <Value>lab</Value>
          <PlainText>true</PlainText>
        </Password>
        <LogonCount>999</LogonCount>
      </AutoLogon>
      <TimeZone>Central Standard Time</TimeZone>
    </component>
  </settings>
</unattend>
XMLEOF

echo "Building ISO..."
genisoimage \
    -o "$OUT_ISO" \
    -b boot/etfsboot.com \
    -no-emul-boot \
    -boot-load-seg 0x07C0 \
    -boot-load-size 8 \
    -iso-level 4 \
    -UDF \
    -joliet \
    -D \
    -relaxed-filenames \
    "$WORK/win"

echo "=== Done: $OUT_ISO ==="
ls -lh "$OUT_ISO"

# Cleanup
rm -rf "$WORK"
