# sgit-privacy-live

**Digitale Souveränität für kleine Unternehmen**

Version: 0.1.0-final-planning  
Stand: 2026-01-13  
Lizenz: GPL-3.0  
Maintainer: sgit.space

---

## Philosophie & Grundsätze

### sgit.space Mission

> "Digitale Souveränität durch echte Open-Source-Lösungen"

sgit-privacy-live verkörpert diese Mission: Ein vollständig selbstbestimmtes, privacy-fokussiertes System ohne Abhängigkeiten von Cloud-Diensten oder proprietärer Software.

### Lizenz-Policy

**STRIKT: Nur OSI-approved Lizenzen!**

| ✅ Erlaubt | ❌ Verboten |
|-----------|------------|
| MIT | Elastic License |
| GPL-2.0 / GPL-3.0 | SSPL |
| Apache-2.0 | BSL (Business Source License) |
| BSD-2-Clause / BSD-3-Clause | Commons Clause |
| MPL-2.0 | Proprietary |
| LGPL | "Source Available" |
| AGPL-3.0 | Freemium mit closed-source Core |
| ISC | |

**Vor jeder Paketaufnahme:** Lizenz auf https://opensource.org/licenses prüfen!

### Zielgruppe

- Kleine Unternehmen (Kernzielgruppe von sgit.space)
- IT-Dienstleister wie sgit.space selbst
- Privacy-bewusste Endanwender
- Kunden von sgit.space (White-Label-fähig)

---

## Offene Punkte

| Thema | Status | Priorität | Notizen |
|-------|--------|-----------|---------|
| **Farbschema** | ✅ Geklärt | - | #14350d (dunkel), #43b02a (hell), #ffffff |
| **Logo/Assets** | ✅ Vorhanden | - | /branding/Webreadyfiles/, Printreadyfiles/ |
| **Typografie** | ✅ Geklärt | - | Space Grotesk + Inter + JetBrains Mono (alle OFL) |
| **n8n/MCP** | ⚠️ Lizenzproblem | MITTEL | n8n nicht OSI → Activepieces (MIT) prüfen |
| **Netbird-Server** | 📋 Separates Projekt | - | vpn.sgit.space, self-hosted auf Proxmox |
| **Stalwart Mail** | ✅ Geklärt | - | mail.sgit.space |
| **Domains** | ✅ Geklärt | - | sgit.space, fussenecker-transport.de |
| **Build-Server** | ✅ Geklärt | - | VM auf pve.sgit.space |
| **OpenPGP** | ✅ Geklärt | - | Optional im OOBE, User generiert/importiert |

---

## Verwandte Projekte

| Projekt | Status | Beschreibung |
|---------|--------|--------------|
| **sgit-privacy-live** | 📋 In Planung | Diese Distribution |
| **vpn.sgit.space** | 📋 Separates Projekt | Netbird Management Server, self-hosted |
| **mail.sgit.space** | ✅ Aktiv | Stalwart Mail Server (CT 107) |
| **pve.sgit.space** | ✅ Aktiv | Proxmox Host für alle Services |

---

## First-Run Setup: sgit-oobe

### Konzept

Beim ersten Boot startet ein freundlicher Setup-Wizard (Out-of-Box Experience), der den Benutzer durch die Einrichtung führt.

### OOBE-Flow (7 Schritte)

| Schritt | Titel | Inhalt |
|---------|-------|--------|
| 1 | 🌍 Sprache & Region | Sprache, Tastaturlayout, Zeitzone |
| 2 | 👤 Benutzerkonto | Vorname, Nachname → `vorname.nachname`, Passwort |
| 3 | 📧 E-Mail | Stalwart-Account (mail.sgit.space), OpenPGP |
| 4 | 🌐 Netzwerk & VPN | WLAN, Netbird (vpn.sgit.space) |
| 5 | 🔒 Privacy-Profil | Standard / Streng / Minimal |
| 6 | 💾 Persistenz | Verschlüsselte Partition oder amnesisch |
| 7 | ✅ Zusammenfassung | Übersicht aller Einstellungen |

### Benutzer-Erstellung

**Format:** `vorname.nachname`

| Eingabe | Generiert |
|---------|-----------|
| Max Mustermann | `max.mustermann` |
| Jürgen Müller | `juergen.mueller` |
| Sarah O'Brien | `sarah.obrien` |

**Gruppen-Mitgliedschaften:**
- `sudo` - Administrative Rechte
- `netdev` - Netzwerk-Konfiguration
- `audio`, `video` - Multimedia
- `plugdev`, `bluetooth` - Hardware
- `scanner`, `lpadmin` - Peripherie

### E-Mail Setup (Stalwart)

**Vorkonfigurierte Server:**
- IMAP: `mail.sgit.space:993` (SSL)
- SMTP: `mail.sgit.space:465` (SSL)

**Unterstützte Domains:**
- `@sgit.space`
- `@fussenecker-transport.de`

**OpenPGP-Optionen:**
1. Neuen 4096-bit RSA-Schlüssel generieren
2. Existierenden Schlüssel importieren
3. Später einrichten

### VPN Setup (Netbird)

**Vorkonfiguration:**
- Management-URL: `vpn.sgit.space`
- Setup-Key vom Admin anfordern

---

## Build-Infrastruktur

### Übersicht

```
pve.sgit.space (Proxmox VE 9.1.2)
├── VM 120: sgit-live-builder
│   ├── Debian 12 / 4 vCPU / 8GB RAM / 100GB Disk
│   ├── live-build Environment
│   ├── QEMU für Tests (nested virtualization)
│   └── GPG für Signierung
│
└── Output → QNAP NAS → sgit.space/privacy-live/downloads/
```

### VM erstellen

```bash
# Auf pve.sgit.space
qm create 120 \
    --name sgit-live-builder \
    --memory 8192 \
    --cores 4 \
    --cpu host \
    --net0 virtio,bridge=vmbr0 \
    --scsihw virtio-scsi-single \
    --scsi0 local-lvm:100,discard=on,ssd=1 \
    --ide2 local:iso/debian-12.9-amd64-netinst.iso,media=cdrom \
    --boot order=scsi0;ide2 \
    --ostype l26 \
    --agent enabled=1

# Nested Virtualization aktivieren
qm set 120 --cpu host,flags=+vmx
```

### Build-Environment Setup

```bash
#!/bin/bash
# setup-build-env.sh

apt update && apt upgrade -y

apt install -y \
    live-build debootstrap git gnupg \
    wget curl rsync \
    qemu-system-x86 qemu-utils ovmf \
    xorriso isolinux syslinux-common squashfs-tools

mkdir -p /home/builder/sgit-privacy-live
```

### Build-Script

```bash
#!/bin/bash
# scripts/build.sh

VERSION="0.1.0"
BUILD_DATE=$(date +%Y%m%d)
IMAGE_NAME="sgit-privacy-live-${VERSION}-${BUILD_DATE}"

sudo lb clean --purge

sudo lb config \
    --distribution bookworm \
    --archive-areas "main contrib non-free non-free-firmware" \
    --binary-images iso-hybrid \
    --bootappend-live "boot=live components quiet splash locales=de_DE.UTF-8 keyboard-layouts=de" \
    --iso-application "sgit-privacy-live" \
    --iso-publisher "sgit.space <support@sgit.space>" \
    --iso-volume "SGIT-PRIVACY" \
    --firmware-binary true \
    --security true \
    --updates true

sudo lb build 2>&1 | tee "build-${BUILD_DATE}.log"

mv live-image-amd64.hybrid.iso "${IMAGE_NAME}.iso"
sha256sum "${IMAGE_NAME}.iso" > "${IMAGE_NAME}.iso.sha256"
gpg --detach-sign --armor "${IMAGE_NAME}.iso"
```

### Release veröffentlichen

```bash
#!/bin/bash
# scripts/release.sh

VERSION="$1"
RELEASE_DIR="/mnt/nas/sgit-privacy-live/releases/${VERSION}"

mount -t cifs //nas.sgit.space/share /mnt/nas -o credentials=/root/.nas-creds
mkdir -p "${RELEASE_DIR}"
cp sgit-privacy-live-${VERSION}*.iso* "${RELEASE_DIR}/"
ln -sfn "${VERSION}" "/mnt/nas/sgit-privacy-live/releases/latest"
```

---

## Privacy-Stack

### Kill Switch (nftables)

| Modus | Beschreibung |
|-------|--------------|
| **Strict** | Nur VPN-Traffic erlaubt |
| **LAN-Allowed** | VPN + lokales Netzwerk |
| **Disabled** | Firewall deaktiviert |

### Kernel-Hardening

```bash
# /etc/sysctl.d/99-sgit-privacy.conf
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
kernel.kptr_restrict = 2
kernel.dmesg_restrict = 1
kernel.yama.ptrace_scope = 1
```

### DNS-Verschlüsselung

- DNSCrypt-proxy mit Quad9/Cloudflare
- DNSSEC erforderlich
- Keine Logging-Server

### MAC-Randomisierung

```ini
# /etc/NetworkManager/conf.d/99-random-mac.conf
[device]
wifi.scan-rand-mac-address=yes

[connection]
wifi.cloned-mac-address=random
ethernet.cloned-mac-address=random
```

---

## Software-Stack

### Basis-System

| Komponente | Paket | Lizenz |
|------------|-------|--------|
| Kernel | linux-image-amd64 | GPL-2.0 |
| Desktop | XFCE4 | GPL-2.0 |
| Display Manager | LightDM | GPL-3.0 |
| Netzwerk | NetworkManager | GPL-2.0 |

### Privacy & Security

| Paket | Lizenz | Funktion |
|-------|--------|----------|
| nftables | GPL-2.0 | Firewall (Kill Switch) |
| apparmor | GPL-2.0 | Mandatory Access Control |
| dnscrypt-proxy | ISC | DNS-Verschlüsselung |
| gnupg | GPL-3.0 | Verschlüsselung |
| veracrypt | Apache-2.0 | Container-Verschlüsselung |
| mat2 | GPL-3.0 | Metadaten-Bereinigung |
| fail2ban | GPL-2.0 | Intrusion Prevention |

### VPN & Netzwerk

| Paket | Lizenz | Funktion |
|-------|--------|----------|
| netbird | BSD-3-Clause | Mesh-VPN (vpn.sgit.space) |
| wireguard-tools | GPL-2.0 | WireGuard-Basis |

### Browser & Kommunikation

| Paket | Lizenz | Funktion |
|-------|--------|----------|
| firefox-esr | MPL-2.0 | Browser (gehärtet) |
| thunderbird | MPL-2.0 | E-Mail (Stalwart) |
| torbrowser-launcher | MIT | Tor Browser |
| simplex-chat | AGPL-3.0 | Messenger |
| nextcloud-desktop | GPL-2.0 | Sync-Client |

### Office & Dokumente

| Paket | Lizenz | Funktion |
|-------|--------|----------|
| libreoffice | MPL-2.0 | Office-Suite |
| evince | GPL-2.0 | PDF-Viewer |
| gimp | GPL-3.0 | Bildbearbeitung |

### Entwickler-Tools

| Paket | Lizenz | Funktion |
|-------|--------|----------|
| git | GPL-2.0 | Versionskontrolle |
| neovim | Apache-2.0 | Editor |
| shellcheck | GPL-3.0 | Shell-Linter |
| jq / yq | MIT | JSON/YAML |
| ripgrep | MIT | Schneller grep |
| podman | Apache-2.0 | Container |

### Netzwerk-Tools

| Paket | Lizenz | Funktion |
|-------|--------|----------|
| wireshark | GPL-2.0 | Paket-Analyse |
| nmap | NPSL | Port-Scanner |
| mtr | GPL-2.0 | Traceroute |
| iperf3 | BSD-3-Clause | Bandbreiten-Test |
| aircrack-ng | GPL-2.0 | WLAN-Audit ⚠️ |

⚠️ **Aircrack-ng**: Nur für eigene Netzwerke! Rechtliche Hinweise im System.

---

## Browser-Konfiguration

### Firefox Startseite & Bookmarks

**Startseite:** `https://sgit.space`

**Lesezeichen-Toolbar:**
- sgit.space
- Privacy Live Dokumentation
- Support
- DuckDuckGo
- ProtonMail

### Firefox Privacy-Hardening

```javascript
// /etc/firefox-esr/syspref.js
pref("browser.startup.homepage", "https://sgit.space");
pref("privacy.trackingprotection.enabled", true);
pref("network.dns.disablePrefetch", true);
pref("media.peerconnection.enabled", false);  // WebRTC leak
pref("dom.battery.enabled", false);
pref("geo.enabled", false);
```

### Stalwart Mail Autoconfig

```xml
<!-- /usr/share/thunderbird/isp/sgit.space.xml -->
<clientConfig>
  <emailProvider id="sgit.space">
    <domain>sgit.space</domain>
    <domain>fussenecker-transport.de</domain>
    <incomingServer type="imap">
      <hostname>mail.sgit.space</hostname>
      <port>993</port>
      <socketType>SSL</socketType>
    </incomingServer>
    <outgoingServer type="smtp">
      <hostname>mail.sgit.space</hostname>
      <port>465</port>
      <socketType>SSL</socketType>
    </outgoingServer>
  </emailProvider>
</clientConfig>
```

---

## sgit-Tools

### sgit-privacy-center

Zentrale Steuerung aller Privacy-Features.

**CLI:**
```bash
sgit-privacy status          # Zeigt aktuellen Status
sgit-privacy killswitch on   # Kill Switch aktivieren
sgit-privacy profile strict  # Profil wechseln
sgit-privacy panic           # Sofort alles blockieren
```

**GUI:** GTK4-Anwendung mit System-Tray-Icon
- 🟢 Geschützt (VPN aktiv, Kill Switch an)
- 🟡 Teilweise (ohne VPN, LAN erlaubt)
- 🔴 Ungeschützt (VPN getrennt)

### sgit-apps

Flatpak-basierter App-Manager.

```bash
sgit-apps list               # Verfügbare Apps
sgit-apps install signal     # App installieren
sgit-apps update             # Alle Apps aktualisieren
```

### sgit-maintain

Automatische Wartung (täglich 04:00 Uhr).

- APT Updates
- Flatpak Updates
- Netbird Updates
- Journal-Cleanup
- Security-Check

### sgit-theme

CI-System für White-Label-Deployment.

```bash
sgit-theme apply             # Theme anwenden
sgit-theme import kunde.tar.gz  # Kunden-Branding
sgit-theme reset             # Zurück zu sgit.space
```

---

## Projektphasen

| Phase | Dauer | Inhalt | Status |
|-------|-------|--------|--------|
| 1 | 2 Wochen | Basis-System (live-build, XFCE, Netzwerk) | 📋 Geplant |
| 2 | 2 Wochen | OOBE-Wizard (GTK4, User-Setup, E-Mail) | 📋 Geplant |
| 3 | 2 Wochen | Privacy-Stack (Kill Switch, Hardening) | 📋 Geplant |
| 4 | 2 Wochen | sgit-privacy-center (CLI + GUI) | 📋 Geplant |
| 5 | 1 Woche | Browser & Apps (Firefox, Thunderbird) | 📋 Geplant |
| 6 | 1 Woche | Entwickler-Tools | 📋 Geplant |
| 7 | 1 Woche | sgit-apps & sgit-maintain | 📋 Geplant |
| 8 | 1 Woche | CI-System & Branding | 📋 Geplant |
| 9 | 2 Wochen | Testing (VM, Hardware, Penetration) | 📋 Geplant |
| 10 | 1 Woche | Release (ISO, Signatur, Docs) | 📋 Geplant |

**Gesamt:** ~14 Wochen

---

## Download-Struktur

```
https://sgit.space/privacy-live/
├── index.html
├── downloads/
│   ├── latest/
│   │   ├── sgit-privacy-live-0.1.0-YYYYMMDD.iso
│   │   ├── sgit-privacy-live-0.1.0-YYYYMMDD.iso.sha256
│   │   └── sgit-privacy-live-0.1.0-YYYYMMDD.iso.asc
│   └── archive/
├── docs/
│   ├── installation.html
│   ├── erste-schritte.html
│   └── custom-branding.html
├── verify.html
└── gpg-key.asc
```

### Signatur-Verifizierung

```bash
# GPG-Schlüssel importieren
wget https://sgit.space/privacy-live/gpg-key.asc
gpg --import gpg-key.asc

# ISO herunterladen
wget https://sgit.space/privacy-live/downloads/latest/sgit-privacy-live-*.iso
wget https://sgit.space/privacy-live/downloads/latest/sgit-privacy-live-*.iso.sha256
wget https://sgit.space/privacy-live/downloads/latest/sgit-privacy-live-*.iso.asc

# Prüfen
sha256sum -c *.sha256
gpg --verify *.asc
```

---

## Zusammenfassung

**sgit-privacy-live** ist eine vollständige Privacy-Distribution nach sgit.space Philosophie:

| Feature | Beschreibung |
|---------|--------------|
| 🔓 **100% Open Source** | Nur OSI-approved Lizenzen |
| 🧑‍💻 **Benutzerfreundlich** | OOBE-Wizard wie Windows/macOS |
| 🔒 **Privacy by Default** | Kill Switch, DNS-Verschlüsselung |
| 📧 **E-Mail integriert** | Stalwart (mail.sgit.space) vorkonfiguriert |
| 🌐 **VPN ready** | Netbird (vpn.sgit.space) |
| 🛠️ **Professionell** | Entwickler- und Netzwerk-Tools |
| 🎨 **White-Label** | Anpassbar für Kunden |

**ISO-Größe:** ~4-5 GB  
**Build-Server:** VM 120 auf pve.sgit.space

---

*sgit.space - Digitale Souveränität für kleine Unternehmen*

---

## sgit.space Branding

### Farbpalette

| Farbe | HEX | RGB | CMYK | Verwendung |
|-------|-----|-----|------|------------|
| **Dunkelgrün (Primary)** | `#14350d` | 20, 53, 13 | 62, 0, 75, 79 | Hintergründe, Headers |
| **Hellgrün (Accent)** | `#43b02a` | 67, 176, 42 | 61, 0, 76, 30 | Buttons, Links, Highlights |
| **Weiß** | `#ffffff` | 255, 255, 255 | 0, 0, 0, 0 | Text auf dunklem Grund |

### Typografie (Open Source - OFL 1.1)

| Font | Verwendung | Lizenz | Download |
|------|------------|--------|----------|
| **Space Grotesk** | Display, Headlines | OFL ✅ | fonts.google.com/specimen/Space+Grotesk |
| **Inter** | Body, UI | OFL ✅ | fonts.google.com/specimen/Inter |
| **JetBrains Mono** | Code, Terminal | OFL ✅ | fonts.google.com/specimen/JetBrains+Mono |

**Warum diese Kombination?**
- **Space Grotesk**: Technisch, geometrisch, modern - perfekt für IT
- **Inter**: Der UI-Font-Standard (von Figma-Gründer), extrem lesbar
- **JetBrains Mono**: Beste Code-Font mit Ligaturen

**Hinweis:** Age + Coolvetica aus den Brand Guidelines sind lizenzpflichtig und werden NICHT verwendet.

### Logo

- 3D-Würfel mit Netzwerk-Verbindungspunkten
- Symbolisiert: Vernetzung, Infrastruktur, Mesh-VPN
- Assets in: `/branding/Webreadyfiles/` und `/branding/Printreadyfiles/`

### E-Mail-Signatur (Vorlage)

```
┌─────────────────────────────────────────────────────────────┐
│  [Logo]  │  Steven Günther                                  │
│          │  Geschäftsführung / Lead Engineer                │
│          │                                                  │
│          │  sgit.space                                      │
│          │  IT-Infrastruktur für kleine Unternehmen         │
│          │  ─────────────────────────────────────────────   │
│          │  Tel: +49 (157) 71660200                         │
│          │  Mail: steven.guenther@sgit.space                │
│          │  Web: https://sgit.space                         │
└─────────────────────────────────────────────────────────────┘
```

### Theme-Konfiguration (sgit-theme)

```yaml
# /etc/sgit-theme/theme.yaml
brand:
  name: "sgit.space"
  tagline: "Digitale Souveränität für kleine Unternehmen"
  website: "https://sgit.space"

colors:
  primary: "#14350d"      # Dunkelgrün
  accent: "#43b02a"       # Hellgrün
  background: "#14350d"
  surface: "#1a4510"
  text_primary: "#ffffff"
  text_secondary: "#e0e0e0"
  border: "#43b02a"

typography:
  display: "Space Grotesk"
  body: "Inter"
  monospace: "JetBrains Mono"
  fallback: "system-ui, sans-serif"
```

### GTK-Theme Generierung

```css
/* Generated: /usr/share/themes/sgit-space/gtk-4.0/gtk.css */
@define-color accent_color #43b02a;
@define-color accent_bg_color #43b02a;
@define-color accent_fg_color #ffffff;
@define-color window_bg_color #14350d;
@define-color window_fg_color #ffffff;
@define-color headerbar_bg_color #14350d;
@define-color headerbar_fg_color #ffffff;
@define-color card_bg_color #1a4510;
@define-color card_fg_color #ffffff;
```

---

## n8n & MCP Integration

### Warum n8n + MCP?

**Model Context Protocol (MCP)** ist ein standardisiertes Protokoll, das KI-Assistenten (wie Claude) ermöglicht, mit externen Tools zu kommunizieren. Die Kombination mit **n8n** (Open-Source Workflow-Automatisierung) eröffnet massive Möglichkeiten:

| Feature | Beschreibung |
|---------|--------------|
| **AI-gesteuerte Automatisierung** | Claude erstellt n8n Workflows aus natürlicher Sprache |
| **Workflow-Management** | KI kann Workflows lesen, erstellen, debuggen |
| **Universal-Connector** | MCP als Brücke zwischen KI und 1000+ n8n Nodes |
| **Self-hosted** | Volle Kontrolle, keine Cloud-Abhängigkeit |

### Relevanz für sgit-privacy-live

**Integration in das OS:**

1. **n8n als vorinstallierte Automatisierungsplattform**
   - Docker-Container oder native Installation
   - Vorkonfiguriert mit sgit.space Services
   - Workflows für häufige Aufgaben

2. **MCP-Server für lokale KI-Assistenten**
   - Claude Code / Cursor / VS Code Integration
   - Lokaler MCP-Server für Workflow-Erstellung
   - Keine Cloud-Verbindung nötig

3. **Automatisierungs-Workflows für Kunden**
   - Backup-Automatisierung
   - Monitoring-Alerts
   - E-Mail-Verarbeitung
   - Dokumenten-Management

### Architektur-Konzept

```
┌─────────────────────────────────────────────────────────────┐
│  sgit-privacy-live                                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────┐    ┌─────────────────┐                │
│  │  Claude Code    │◄──►│  MCP Server     │                │
│  │  (lokal)        │    │  (localhost)    │                │
│  └─────────────────┘    └────────┬────────┘                │
│                                  │                          │
│                                  ▼                          │
│  ┌─────────────────────────────────────────┐               │
│  │  n8n (Docker/Native)                    │               │
│  │  ├── Workflow: Backup-Automation        │               │
│  │  ├── Workflow: Mail-Processing          │               │
│  │  ├── Workflow: Monitoring-Alerts        │               │
│  │  └── Workflow: Custom...                │               │
│  └────────────────────┬────────────────────┘               │
│                       │                                     │
│                       ▼                                     │
│  ┌─────────────────────────────────────────┐               │
│  │  sgit.space Services (via VPN)          │               │
│  │  ├── mail.sgit.space (Stalwart)         │               │
│  │  ├── cloud.sgit.space (Nextcloud)       │               │
│  │  └── vpn.sgit.space (Netbird)           │               │
│  └─────────────────────────────────────────┘               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### n8n Lizenz-Check

| Komponente | Lizenz | Status |
|------------|--------|--------|
| n8n Core | **Fair-code (Sustainable Use License)** | ⚠️ **NICHT OSI!** |
| n8n Community Edition | Apache-2.0 (bis v0.214) | ✅ Alte Version |

**⚠️ WICHTIG:** n8n verwendet seit 2022 die "Sustainable Use License" - das ist **NICHT** OSI-approved!

### Alternativen (100% Open Source)

| Tool | Lizenz | Beschreibung |
|------|--------|--------------|
| **Huginn** | MIT ✅ | Self-hosted IFTTT Alternative |
| **Activepieces** | MIT ✅ | n8n-ähnlich, vollständig Open Source |
| **Node-RED** | Apache-2.0 ✅ | Flow-based Programming |
| **Automatisch** | MIT ✅ | Zapier Alternative |

### Empfehlung

**Option A: Activepieces (MIT)**
- Modernste Alternative zu n8n
- Vollständig Open Source
- MCP-Integration möglich

**Option B: Node-RED (Apache-2.0)**
- Bewährt und stabil
- Große Community
- IoT-fokussiert aber flexibel

**Option C: n8n Community (alte Version)**
- Letzte Apache-2.0 Version (v0.214)
- Keine Updates, aber funktional
- Nicht empfohlen für Produktion

### MCP-Server Setup (unabhängig vom Automatisierungstool)

```bash
# MCP-Server für Claude Code
npm install -g @anthropic-ai/mcp

# Lokale Konfiguration
mkdir -p ~/.config/claude-code
cat > ~/.config/claude-code/mcp.json << 'EOF'
{
  "servers": {
    "sgit-automation": {
      "command": "node",
      "args": ["path/to/mcp-server/index.js"],
      "env": {
        "AUTOMATION_API_URL": "http://localhost:5678",
        "AUTOMATION_API_KEY": "${AUTOMATION_KEY}"
      }
    }
  }
}
EOF
```

### Fazit

| Aspekt | Bewertung |
|--------|-----------|
| n8n direkt integrieren | ❌ Lizenz nicht OSI-konform |
| Activepieces als Alternative | ✅ MIT-Lizenz, empfohlen |
| MCP-Integration | ✅ Unabhängig vom Backend |
| Claude Code lokal | ✅ Privacy-freundlich |
