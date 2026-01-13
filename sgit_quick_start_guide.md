# sgiT Projekt-Template - Quick Start Guide

**Version:** 1.2  
**Letzte Aktualisierung:** 2025-12-08

## 🚀 SOFORT-ANWEISUNGEN FÜR CLAUDE

### Bei JEDEM neuen Chat mit Claude zu einem Projekt:

```
SCHRITT 1: Status-Report lesen
→ [PROJEKT]_status_report.md öffnen

SCHRITT 2: Aktuellen Stand erfassen
→ Was funktioniert?
→ Was ist in Bearbeitung?
→ Welche Probleme gibt es?

SCHRITT 3: Nächste TODOs identifizieren
→ Was ist die höchste Priorität?
→ Was sind die nächsten logischen Schritte?
```

---

## 📋 KERNPRINZIPIEN (IMMER BEACHTEN!)

### 1. **DOCUMENTATION FIRST**
```
✓ Erst dokumentieren, dann coden
✓ Jede Änderung im Status-Report
✓ Alle Erkenntnisse festhalten
```

### 2. **SYSTEMATIC DEBUGGING**
```
✓ Detaillierte Log-Ausgaben
✓ Version Numbering (v1.0, v1.1, ...)
✓ Jede Iteration dokumentieren
✓ Testing vor Deployment
```

### 3. **COMPREHENSIVE COMMENTING**
```php
// IMMER:
- File Headers mit Version
- Function Documentation
- Inline Comments für komplexe Logik
- Change History in Comments
```

### 4. **CONSISTENT STRUCTURE**
```
✓ Einheitliche Namenskonventionen
✓ Gleiche Ordnerstruktur
✓ Konsistente Code-Patterns
✓ Unified Error Handling
```

---

## 🎯 5-MINUTEN PROJECT SETUP

### Neues Projekt starten:

```bash
# 1. Ordnerstruktur
mkdir projekt_name
cd projekt_name
mkdir core modules assets logs database tests

# 2. Template kopieren
cp sgit_project_template.md projekt_name_template.md

# 3. Status-Report initialisieren
cp template_status_report.md projekt_name_status_report.md

# 4. Git initialisieren
git init
git add .
git commit -m "INIT: Project setup mit sgiT Template"

# 5. Erste Zeile im Status-Report:
echo "# Projekt gestartet am $(date)" >> projekt_name_status_report.md
```

---

## 🔧 DEBUG-WORKFLOW (KOPIEREN & NUTZEN)

### Wenn ein Problem auftritt:

```
SCHRITT 1: PROBLEM DOKUMENTIEREN
──────────────────────────────────
Problem: [Was ist kaputt?]
Symptom: [Wie äußert es sich?]
Reproduktion: [Schritt-für-Schritt]
Erwartet: [Was sollte passieren?]
Tatsächlich: [Was passiert wirklich?]

SCHRITT 2: LOGGING HINZUFÜGEN
──────────────────────────────────
error_log("DEBUG [v1.0]: Start function X");
error_log("DEBUG [v1.0]: Variable Y = " . print_r($y, true));
error_log("DEBUG [v1.0]: Ende function X");

SCHRITT 3: ITERATIV FIXEN
──────────────────────────────────
v1.0: Initial implementation
v1.1: Added logging für Bereich A
v1.2: Fixed parsing in Bereich B
v1.3: Optimized performance
v1.4: Final version - WORKS!

SCHRITT 4: IM STATUS-REPORT DOKUMENTIEREN
──────────────────────────────────
### Debug-Log: [DATUM] - [Problem]
**Version:** v1.4
**Problem:** [Beschreibung]
**Ursache:** [Root Cause]
**Lösung:** [Was wurde gemacht]
**Verhinderung:** [Wie künftig vermeiden]
```

---

## 📊 STATUS-REPORT TEMPLATE

### Dateiname: `[projekt]_status_report.md`

```markdown
# [PROJEKT] Status Report
**Letzte Aktualisierung:** [DATUM]
**Version:** [X.Y.Z]

## ✅ FUNKTIONIERT
- Feature A (v1.2)
- Feature B (v2.1)

## 🔄 IN BEARBEITUNG
- Feature C (50% - ETA: Morgen)
- Bug Fix D (Debug läuft)

## ⚠️ PROBLEME
- Problem E: [Beschreibung]
  → Workaround: [Temporäre Lösung]
  → TODO: [Geplante Fix]

## 🎯 NÄCHSTE SCHRITTE
1. [Höchste Priorität]
2. [Zweit-Priorität]
3. [Optional]

## 💡 LESSONS LEARNED
- [Erkenntnis 1]: [Details]
- [Erkenntnis 2]: [Details]
```

### 📚 Archiv-Tipp (NEU v1.2)
```
Falls Status-Report > 500 Zeilen:
1. Erstelle [projekt]_ARCHIVE.md
2. Verschiebe: Geschlossene Bugs, alte Sessions
3. Behalte: Offene TODOs, aktuelle Bugs
4. Quick-Start Section IMMER oben!

Grund: AI-Chat-Stabilität, Token-Limit schonen
```

---

## 💻 CODE-QUALITÄT CHEAT-SHEET

### File Header (IMMER!)
```php
/**
 * ═══════════════════════════════════════════════
 * [DATEINAME] - v[X.Y]
 * ═══════════════════════════════════════════════
 * Projekt: [NAME]
 * Zweck: [Was macht diese Datei?]
 * Erstellt: [DATUM]
 * Letzte Änderung: [DATUM]
 * 
 * Änderungen:
 * - v1.0: Initiale Version
 * - v1.1: [Was wurde geändert]
 * ═══════════════════════════════════════════════
 */
```

### Function Header (IMMER!)
```php
/**
 * [Funktionsname] - v[X.Y]
 * 
 * [Kurzbeschreibung in einem Satz]
 * 
 * @param type $param - Beschreibung
 * @return type - Was wird zurückgegeben
 * 
 * Changelog:
 * - v1.0: Initial
 * - v1.1: [Änderung]
 */
```

### Inline Comments (WENN NÖTIG!)
```php
// Komplexe Logik erklären
// Edge Cases dokumentieren
// Workarounds begründen
// Performance-kritische Stellen markieren
```

---

## 🎨 BRANDING QUICK-REFERENCE

### sgiT Corporate Identity
```css
/* Primärfarbe */
--sgit-dark-green: #1A3503;

/* Akzentfarbe */
--sgit-neon-green: #43D240;

/* Logo */
background: url('/assets/sgit-logo.png');
```

### Konsistenz-Regeln
```
✓ Gleiche Navigation auf allen Seiten
✓ Einheitliche Button-Styles
✓ Konsistente Error Messages
✓ Unified Success Messages
```

---

## 🧪 TESTING CHECKLIST

```
□ Funktioniert das Feature?
□ Edge Cases getestet?
□ Error Handling funktioniert?
□ Performance akzeptabel?
□ Mobile responsive?
□ Cross-browser getestet?
□ Security Review gemacht?
□ Dokumentation aktualisiert?
```

---

## 🚨 HÄUFIGE FEHLER VERMEIDEN

### ❌ NICHT tun:
```
- Ohne Logging debuggen
- Direkt in Production coden
- Dokumentation aufschieben
- Versionierung vergessen
- Blind Copy & Paste
- Commits ohne Message
```

### ✅ IMMER tun:
```
- Status-Report lesen vor Session
- Logging bei komplexen Funktionen
- Jede Änderung dokumentieren
- Code kommentieren
- Tests schreiben
- Inkrementell arbeiten
```

---

## 📞 CLAUDE OPTIMAL NUTZEN

### Perfekter Chat-Start:
```
"Lies bitte [projekt]_status_report.md und 
fasse den aktuellen Stand zusammen. 
Was ist der nächste logische Schritt?"
```

### Gute Problem-Beschreibung:
```
"Problem: [Was ist kaputt]
File: [Welche Datei]
Code: [Relevanter Code-Ausschnitt]
Error: [Fehlermeldung]
Expected: [Was sollte passieren]
Actual: [Was passiert]"
```

### Session Ende:
```
"Bitte aktualisiere den Status-Report mit:
- Was wir gemacht haben
- Was funktioniert
- Was noch zu tun ist
- Lessons Learned"
```

---

## 🎯 PROJEKT-PHASEN

### Phase 1: PLANNING (1-2 Tage)
```
✓ Requirements
✓ Tech Stack
✓ Database Schema
✓ UI/UX Mockups
✓ Status-Report initialisieren
```

### Phase 2: CORE DEVELOPMENT (1-2 Wochen)
```
✓ Basic Structure
✓ Database Setup
✓ Authentication
✓ Core Features
✓ Testing Framework
```

### Phase 3: FEATURES (2-4 Wochen)
```
✓ Modul für Modul
✓ Kontinuierliche Tests
✓ Dokumentation parallel
✓ Code Reviews
```

### Phase 4: POLISH (1 Woche)
```
✓ Bug Fixes
✓ Performance Optimization
✓ UI/UX Refinement
✓ Security Audit
✓ Final Documentation
```

### Phase 5: DEPLOYMENT
```
✓ Staging Tests
✓ Production Deploy
✓ Monitoring Setup
✓ User Training
✓ Support Ready
```

---

## 🔄 VERSIONIERUNG

### Semantic Versioning
```
v[MAJOR].[MINOR].[PATCH]

MAJOR: Breaking Changes
MINOR: New Features
PATCH: Bug Fixes

Beispiel:
v1.0.0 → Initial Release
v1.1.0 → New Feature Added
v1.1.1 → Bug Fix
v2.0.0 → Major Rewrite
```

---

## 📁 STANDARD ORDNERSTRUKTUR

```
/projekt_root/
├── /core/              # Kern-Funktionalität
│   ├── config.php
│   ├── database.php
│   └── functions.php
├── /modules/           # Feature-Module
│   ├── /modul_a/
│   └── /modul_b/
├── /assets/           # Statische Ressourcen
│   ├── /css/
│   ├── /js/
│   └── /images/
├── /logs/             # Log-Dateien
├── /database/         # DB-Files (SQLite)
├── /tests/            # Test-Suites
├── projekt_status_report.md
├── README.md
└── index.php
```

---

## 💾 BACKUP STRATEGIE

### Täglich:
```bash
# Git Commit
git add .
git commit -m "[TYPE]: Description"
git push

# Database Backup
cp database/projekt.db backups/projekt_$(date +%Y%m%d).db
```

### Wöchentlich:
```bash
# Full Project Backup
tar -czf projekt_backup_$(date +%Y%m%d).tar.gz projekt_root/
```

---

## 🎓 LESSONS LEARNED TEMPLATE

```markdown
### [DATUM] - [THEMA]

**Problem:**
[Was war die Herausforderung?]

**Versuchte Lösungen:**
1. [Ansatz 1] → Funktionierte nicht weil...
2. [Ansatz 2] → Funktionierte nicht weil...
3. [Ansatz 3] → FUNKTIONIERTE weil...

**Finale Lösung:**
[Detaillierte Beschreibung]

**Anwendbar auf:**
- [Ähnliche Situation 1]
- [Ähnliche Situation 2]

**Key Takeaway:**
[Eine-Satz-Zusammenfassung]
```

---

## ⚡ PERFORMANCE CHECKLIST

```
□ Database Queries optimiert?
□ Caching implementiert?
□ Lazy Loading verwendet?
□ Images komprimiert?
□ CSS/JS minified?
□ Unnötige Requests reduziert?
□ Server Response Time < 200ms?
□ Page Load Time < 3s?
```

---

## 🔐 SECURITY CHECKLIST

```
□ Input Validation
□ SQL Injection Prevention
□ XSS Protection
□ CSRF Tokens
□ Secure Password Hashing
□ HTTPS enforced
□ Session Security
□ Error Messages neutral
□ File Upload Validation
□ Rate Limiting
```

---

## 🔗 QUICK LINKS (Most Used)

### Development:
```
PHP Docs:           https://www.php.net/docs.php
JavaScript MDN:     https://developer.mozilla.org/en-US/docs/Web/JavaScript
SQLite Docs:        https://www.sqlite.org/docs.html
```

### Version Control:
```
Git Documentation:  https://git-scm.com/doc
GitHub Guides:      https://guides.github.com/
Semantic Versioning: https://semver.org/
```

### Testing & Security:
```
PHPUnit:            https://phpunit.de/
OWASP Top 10:       https://owasp.org/www-project-top-ten/
OWASP Cheat Sheets: https://cheatsheetseries.owasp.org/
```

### AI Tools:
```
Ollama Docs:        https://ollama.ai/
OpenAI API:         https://platform.openai.com/docs
```

### Performance:
```
PageSpeed Insights: https://pagespeed.web.dev/
web.dev:            https://web.dev/
```

### Learning:
```
freeCodeCamp:       https://www.freecodecamp.org/
MDN Learning:       https://developer.mozilla.org/en-US/docs/Learn
Stack Overflow:     https://stackoverflow.com/
```

### Austrian Economics & Bitcoin:
```
Mises Institute:    https://mises.org/
Bitcoin.org:        https://bitcoin.org/
Learn Me A Bitcoin: https://learnmeabitcoin.com/
```

---

**Template Version:** 1.2
**Für:** Alle zukünftigen sgiT Projekte
**Letzte Aktualisierung:** 2025-12-08 (Archiv-Tipp hinzugefügt)
**Maintained by:** deStevie

═══════════════════════════════════════════════════
DIESES DOKUMENT IN JEDEN PROJECT-ORDNER KOPIEREN!
═══════════════════════════════════════════════════
