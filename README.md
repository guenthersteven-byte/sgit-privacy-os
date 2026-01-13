# sgit-privacy-live

**Digitale Souveränität für kleine Unternehmen**

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://opensource.org/licenses/GPL-3.0)
[![Status](https://img.shields.io/badge/Status-In%20Development-yellow.svg)]()

---

## Was ist sgit-privacy-live?

Eine privacy-fokussierte Linux-Distribution basierend auf **Debian 13 (Trixie)**, entwickelt von [sgit.space](https://sgit.space).

### Features

- **100% Open Source** - Nur OSI-approved Lizenzen (MIT, GPL, Apache, BSD, MPL)
- **Privacy by Default** - Kill Switch, DNS-Verschlüsselung, MAC-Randomisierung
- **OOBE-Wizard** - Benutzerfreundliches Setup wie Windows/macOS
- **VPN ready** - Netbird (vpn.sgit.space) vorkonfiguriert
- **E-Mail integriert** - Stalwart Mail (mail.sgit.space) vorkonfiguriert
- **White-Label fähig** - Anpassbar für Kunden

### Desktop & Software

| Komponente | Software |
|------------|----------|
| Desktop | XFCE4 |
| Browser | Firefox ESR (gehärtet) |
| E-Mail | Thunderbird |
| Office | LibreOffice |
| VPN | Netbird + WireGuard |

---

## Quick Start

### ISO herunterladen

```bash
# Download (nach Release)
wget https://sgit.space/privacy-live/downloads/latest/sgit-privacy-live-*.iso

# Verifizieren
sha256sum -c sgit-privacy-live-*.iso.sha256
gpg --verify sgit-privacy-live-*.iso.asc
```

### Selbst bauen

```bash
# Repository klonen
git clone https://github.com/guenthersteven-byte/sgit-privacy-os.git
cd sgit-privacy-os/live-build

# Build starten (auf Debian 13)
sudo lb clean --purge
sudo lb config
sudo lb build
```

---

## Projektstruktur

```
sgit-privacy-os/
├── README.md                    # Diese Datei
├── sgit-privacy-live-final.md   # Vollständige Spezifikation
├── status-sgit-privacy.md       # Aktueller Projektstatus
└── live-build/
    ├── config/
    │   ├── package-lists/       # Paketlisten
    │   ├── hooks/               # Build-Hooks
    │   └── ...
    └── scripts/                 # Build-Scripts
```

---

## Dokumentation

| Dokument | Beschreibung |
|----------|--------------|
| [sgit-privacy-live-final.md](sgit-privacy-live-final.md) | Vollständige technische Spezifikation |
| [status-sgit-privacy.md](status-sgit-privacy.md) | Aktueller Entwicklungsstatus |

---

## Build-Infrastruktur

| Server | Funktion |
|--------|----------|
| pve.sgit.space | Proxmox Host |
| VM 120 (sgit-live-builder) | Build-Server (Debian 13) |
| mail.sgit.space | Stalwart Mail Server |
| vpn.sgit.space | Netbird VPN Server |

---

## Aktueller Stand

**Version:** 0.2.1
**Letztes ISO:** `sgit-privacy-live-0.2.1-20260113.iso` (1,8 GB)
**Status:** Erstes bootbares ISO erfolgreich gebaut

### Roadmap

- [x] Phase 1: Planung & Spezifikation
- [x] Phase 2: Build-Infrastruktur
- [x] Phase 3: Erstes bootbares ISO (v0.2.1)
- [ ] Phase 4: Privacy-Stack (Kill Switch, Hardening)
- [ ] Phase 5: OOBE-Wizard
- [ ] Phase 6: sgit-privacy-center (CLI + GUI)
- [ ] Phase 7: Testing & Release

---

## Lizenz

GPL-3.0 - Siehe [LICENSE](LICENSE)

---

## Kontakt

- **Website:** https://sgit.space
- **E-Mail:** support@sgit.space
- **Maintainer:** Steven Günther

---

*sgit.space - Digitale Souveränität für kleine Unternehmen*
