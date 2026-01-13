# sgit-privacy-live - Status Report

**Letzte Aktualisierung:** 13.01.2026 20:15
**Version:** 0.4.0-dev-experience
**Lead Engineer:** deStevie
**Status:** 🔨 DEVELOPER-STACK BUILD LÄUFT

---

## 🎯 Projekt-Übersicht

| Aspekt | Details |
|--------|---------|
| **Typ** | Privacy-fokussierte Linux-Distribution (Debian 13 Trixie) |
| **Zielgruppe** | Kleine Unternehmen, IT-Dienstleister, Privacy-bewusste Anwender |
| **Lizenz** | GPL-3.0 (nur OSI-approved Komponenten!) |
| **Build-VM** | VM 120 auf pve.sgit.space |
| **Download** | https://sgit.space/privacy-live/ (nach Release) |

---

## 📊 Projekt-Status

### Phase 1: Planung ✅ ABGESCHLOSSEN

| Aufgabe | Status | Notizen |
|---------|--------|---------|
| Philosophie & Grundsätze | ✅ Erledigt | Nur OSI-Lizenzen, sgit.space Mission |
| Lizenz-Policy | ✅ Erledigt | MIT/GPL/Apache/BSD/MPL erlaubt |
| Farbschema | ✅ Geklärt | #14350d, #43b02a, #ffffff |
| Typografie | ✅ Geklärt | Space Grotesk + Inter + JetBrains Mono (OFL) |
| OOBE-Flow Design | ✅ Erledigt | 7 Schritte definiert |
| Software-Stack | ✅ Definiert | Alle Pakete + Lizenzen dokumentiert |
| Build-Infrastruktur | ✅ Konzept | VM 120 Spezifikation fertig |

### Phase 2: Infrastruktur ✅ ABGESCHLOSSEN

| Aufgabe | Status | Priorität |
|---------|--------|-----------|
| VM 120 erstellen | ✅ Erledigt | - |
| Debian 13 installieren | ✅ Erledigt | - |
| live-build Environment | ✅ Installiert | - |
| Nested Virtualization | ✅ Funktioniert (vmx) | - |
| GPG-Schlüssel für Signierung | ⏳ Ausstehend | 🟡 MITTEL |

### Phase 3: Basis-System ✅ MEILENSTEIN ERREICHT

| Aufgabe | Status | Priorität |
|---------|--------|-----------|
| live-build Config | ✅ Erledigt | - |
| XFCE Paket-Liste | ✅ Erstellt | - |
| Erster ISO-Build | ✅ Erfolgreich (1,8 GB) | - |
| ISO-Struktur verifiziert | ✅ BIOS + UEFI bootbar | - |

**Erstes ISO:** `sgit-privacy-live-0.2.1-20260113.iso` (1,8 GB)

### Phase 4: Privacy-Stack 🔨 IN ARBEIT

| Aufgabe | Status | Priorität |
|---------|--------|-----------|
| nftables Kill Switch | ✅ Implementiert | - |
| Kernel-Hardening (sysctl) | ✅ Konfiguriert | - |
| DNS-Verschlüsselung (dnscrypt-proxy) | ✅ Konfiguriert | - |
| MAC-Randomisierung | ✅ Konfiguriert | - |
| Netbird VPN Integration | ✅ Repo hinzugefügt | - |
| Privacy-Pakete (AppArmor, etc.) | ✅ Paketliste erstellt | - |
| ISO-Build mit Privacy-Stack | 🔄 Läuft | 🔴 HOCH |

**Privacy-Features:**
- `sgit-killswitch` CLI-Tool (on/off/status)
- VPN-only Traffic bei aktivem Kill Switch
- Verschlüsselte DNS-Anfragen (Quad9, Cloudflare, Mullvad)
- Zufällige MAC-Adressen pro Verbindung
- AppArmor Mandatory Access Control

### Phase 5: Developer Experience 🔨 IN ARBEIT

| Aufgabe | Status | Priorität |
|---------|--------|-----------|
| Claude Code (AI CLI) | ✅ Konfiguriert | - |
| Starship Prompt | ✅ Konfiguriert | - |
| Zsh mit Autosuggestions | ✅ Konfiguriert | - |
| Podman Container-Tools | ✅ Paketliste | - |
| Cockpit Web-Console | ✅ Konfiguriert | - |
| Modern CLI Tools (bat, exa, fzf, rg) | ✅ Paketliste | - |
| ISO-Build mit Dev-Tools | 🔄 Läuft | 🔴 HOCH |

**Developer-Features:**
- Claude Code via `claude` Alias
- Starship Prompt mit Git-Integration
- Zsh mit syntax-highlighting und autosuggestions
- Podman (rootless, Docker-kompatibel)
- Cockpit Web-Console unter https://localhost:9090
- Modern CLI: bat, exa, fzf, ripgrep, fd-find, btop, neovim

### Phase 6-12: Entwicklung 📋 GEPLANT

| Phase | Dauer | Inhalt | Status |
|-------|-------|--------|--------|
| 3 | 2 Wochen | Basis-System (live-build, XFCE, Netzwerk) | 📋 Geplant |
| 4 | 2 Wochen | OOBE-Wizard (GTK4, User-Setup, E-Mail) | 📋 Geplant |
| 5 | 2 Wochen | Privacy-Stack (Kill Switch, Hardening) | 📋 Geplant |
| 6 | 2 Wochen | sgit-privacy-center (CLI + GUI) | 📋 Geplant |
| 7 | 1 Woche | Browser & Apps (Firefox, Thunderbird) | 📋 Geplant |
| 8 | 1 Woche | Entwickler-Tools | 📋 Geplant |
| 9 | 1 Woche | sgit-apps & sgit-maintain | 📋 Geplant |
| 10 | 1 Woche | CI-System & Branding | 📋 Geplant |
| 11 | 2 Wochen | Testing (VM, Hardware, Penetration) | 📋 Geplant |
| 12 | 1 Woche | Release (ISO, Signatur, Docs) | 📋 Geplant |

**Geschätzte Gesamtdauer:** ~14 Wochen

---

## ⚠️ Offene Punkte & Abhängigkeiten

| Thema | Status | Priorität | Notizen |
|-------|--------|-----------|---------|
| **n8n/MCP Lizenzproblem** | ⚠️ Offen | MITTEL | n8n = Fair-code (NICHT OSI!), Activepieces (MIT) evaluieren |
| **Netbird-Server** | 📋 Separates Projekt | MITTEL | vpn.sgit.space, self-hosted auf Proxmox |
| **Stalwart Mail** | ✅ Bereit | - | mail.sgit.space verfügbar (CT 107) |
| **Build-VM Hardware** | ✅ Erledigt | - | VM 120: 4 vCPU, 8GB RAM, 100GB Disk |

---

## 🔗 Verwandte Services (Infrastruktur)

| Service | Status | Verbindung zu sgit-privacy |
|---------|--------|---------------------------|
| **pve.sgit.space** | ✅ Aktiv | Host für Build-VM 120 |
| **mail.sgit.space** | ✅ Aktiv | Vorkonfiguriert in OOBE (IMAP/SMTP) |
| **vpn.sgit.space** | 📋 Geplant | Netbird Management Server |
| **cloud.sgit.space** | ✅ Aktiv | Nextcloud Sync-Client vorinstalliert |

---

## 🛠️ Technische Spezifikationen

### Build-VM (VM 120) ✅ BETRIEBSBEREIT

```
VM 120: sgit-live-builder
├── OS: Debian 13 (Trixie) ✅
├── IP: 192.168.200.132
├── vCPU: 4
├── RAM: 8 GB
├── Disk: 100 GB (local-lvm:vm-120-disk-0)
├── CPU: host,flags=+nested-virt ✅
├── Network: virtio, bridge=vmbr0
├── User: builder / root (SSH-Key: SG@sgit-workstation)
├── Tools: live-build, QEMU, GPG ✅
└── Projekt: /home/builder/sgit-privacy-live/
```

### ISO-Spezifikationen

| Aspekt | Wert |
|--------|------|
| Basis | Debian 13 (Trixie) |
| Desktop | XFCE4 |
| Größe | ~4-5 GB |
| Format | iso-hybrid (USB + DVD) |
| Bootloader | GRUB2 (UEFI + Legacy) |

### OOBE-Flow (7 Schritte)

1. 🌍 Sprache & Region
2. 👤 Benutzerkonto (vorname.nachname Format)
3. 📧 E-Mail (Stalwart + OpenPGP)
4. 🌐 Netzwerk & VPN (Netbird)
5. 🔒 Privacy-Profil (Standard/Streng/Minimal)
6. 💾 Persistenz (verschlüsselt oder amnesisch)
7. ✅ Zusammenfassung

---

## 📦 Software-Stack Übersicht

### Kern-Komponenten

| Kategorie | Pakete | Lizenzen |
|-----------|--------|----------|
| Desktop | XFCE4, LightDM | GPL-2.0, GPL-3.0 |
| Privacy | nftables, apparmor, dnscrypt-proxy | GPL-2.0, ISC |
| VPN | Netbird, WireGuard | BSD-3-Clause, GPL-2.0 |
| Browser | Firefox ESR (gehärtet), Tor Browser | MPL-2.0, MIT |
| E-Mail | Thunderbird (Stalwart vorkonfiguriert) | MPL-2.0 |
| Office | LibreOffice, Evince | MPL-2.0, GPL-2.0 |
| Dev-Tools | git, neovim, podman, claude-code | GPL-2.0, Apache-2.0, MIT |
| Shell | Zsh, Starship, tmux | MIT, ISC, BSD |
| Container | Podman, Cockpit | Apache-2.0, LGPL-2.1 |

### sgit-Tools (Eigenentwicklung)

| Tool | Funktion |
|------|----------|
| **sgit-privacy-center** | CLI/GUI für Privacy-Features (Kill Switch, Profile) |
| **sgit-apps** | Flatpak-basierter App-Manager |
| **sgit-maintain** | Automatische Wartung (täglich 04:00) |
| **sgit-theme** | White-Label Branding-System |

---

## 📝 Nächste Schritte

### 🔴 Sofort (heute)

- [x] **VM 120 auf Proxmox erstellen** - ✅ Erledigt (Debian 13, 4 vCPU, 8GB RAM, 100GB)
- [x] **Nested Virtualization konfigurieren** - ✅ Erledigt (host,flags=+nested-virt)
- [ ] **Debian 13 Installation abschließen** - 🔄 Läuft gerade
- [ ] **live-build Environment installieren** - setup-build-env.sh ausführen
- [ ] **Nested Virtualization testen** - QEMU in VM muss funktionieren

### 🟡 Kurzfristig

- [ ] **Erstes Basis-ISO bauen** - Minimal Debian + XFCE
- [ ] **Boot-Test in QEMU** - Funktioniert ISO?
- [ ] **Repository-Struktur anlegen** - Git auf pve oder GitHub?

### 🟢 Mittelfristig

- [ ] **OOBE-Wizard Prototyp** - GTK4 Grundgerüst
- [ ] **Privacy-Stack integrieren** - nftables Kill Switch
- [ ] **Activepieces evaluieren** - n8n-Ersatz für Automatisierung

---

## 📚 Dokumentation

| Dokument | Pfad |
|----------|------|
| **Haupt-Spezifikation** | `sgit-privacy-live-final.md` |
| **Infrastruktur-Kontext** | `../../sgit_status_report_infrastruktur.md` |
| **Branding-Assets** | `/branding/Webreadyfiles/`, `/branding/Printreadyfiles/` |

---

## 🔄 Changelog

| Datum | Version | Änderung |
|-------|---------|----------|
| 13.01.2026 | 0.4.0 | 🔨 Developer Experience: Claude Code, Starship, Zsh, Cockpit |
| 13.01.2026 | 0.3.0 | 🔨 Privacy-Stack: Kill Switch, Hardening, DNS, MAC-Randomisierung |
| 13.01.2026 | 0.2.1 | ✅ **ERSTES ISO ERFOLGREICH!** 1,8 GB, BIOS+UEFI bootbar |
| 13.01.2026 | 0.2.0 | 🔨 Erster ISO-Build gestartet (XFCE + Firefox + Deutsch) |
| 13.01.2026 | 0.1.2 | 🔧 live-build + QEMU installiert, Nested Virt getestet |
| 13.01.2026 | 0.1.1 | 🔧 VM 120 erstellt, Debian 13 installiert, SSH eingerichtet |
| 13.01.2026 | 0.1.0 | 📋 Initiale Planung abgeschlossen, Status-Report erstellt |
| 13.01.2026 | 0.0.1 | 📋 Projekt gestartet, finale Spezifikation dokumentiert |

---

**Report Version:** 0.4.0
**Zeilen:** ~260 / 500 (Archivierung bei >500)
**Archiv:** `status-sgit-privacy_ARCHIVE.md` (wenn nötig)
**Haupt-Doku:** `sgit-privacy-live-final.md`
**Maintained by:** deStevie

═══════════════════════════════════════════════════════════
🔨 IN ARBEIT: Developer Experience Build (Claude Code, Starship, Cockpit)
NÄCHSTER MEILENSTEIN: OOBE-Wizard Prototyp
BEI >500 ZEILEN: Changelog archivieren!
═══════════════════════════════════════════════════════════
