# sgiT Quick Reference Card 🚀

**Version:** 1.2 | **Letzte Aktualisierung:** 2025-12-08

> **📌 1-Seiter zum Ausdrucken/Schnellnachschlagen**

---

## 🔥 SESSION START

```bash
# 1. Status-Report lesen!
[projekt]_status_report.md

# 2. Docker starten
cd /path/to/project/docker && docker-compose up -d

# 3. Mit Claude starten
"Lies bitte [projekt]_status_report.md"
```

---

## 🐳 DOCKER BEFEHLE

| Befehl | Beschreibung |
|--------|--------------|
| `docker-compose up -d` | Container starten |
| `docker-compose down` | Container stoppen |
| `docker-compose logs -f` | Logs anzeigen |
| `docker exec -it [container] bash` | Shell öffnen |
| `docker ps` | Laufende Container |
| `docker system prune -a` | Aufräumen ⚠️ |

### PHP im Container
```bash
docker exec -it sgit_php php /var/www/html/script.php
```

---

## 🤖 OLLAMA/AI

| Befehl | Beschreibung |
|--------|--------------|
| `ollama pull gemma2:2b` | Model laden |
| `ollama list` | Modelle anzeigen |
| `ollama run gemma2:2b "test"` | Model testen |

### Empfohlene Modelle
- **Standard:** `gemma2:2b` (4-6 GB RAM)
- **Schnell:** `llama3.2:1b` (2-3 GB RAM)
- **Qualität:** `mistral:7b` (8+ GB, GPU)

---

## 📝 GIT WORKFLOW

```bash
# Feature Branch
git checkout -b feature/[name]
git add .
git commit -m "[TYPE]: Beschreibung"
git push origin feature/[name]

# Commit Types:
FEAT   - Neues Feature
FIX    - Bug Fix
DOCS   - Dokumentation
STYLE  - Formatierung
REFACTOR - Code Umbau
TEST   - Tests
CHORE  - Wartung
```

---

## 💾 BACKUP

```bash
# Database Backup
cp database.db backups/db_$(date +%Y%m%d).db

# Full Backup
tar -czf backup_$(date +%Y%m%d).tar.gz \
    --exclude='node_modules' \
    --exclude='vendor' \
    /path/to/project
```

### 3-2-1 Regel
- **3** Kopien
- **2** Medien (lokal + cloud)
- **1** Offsite

---

## 🔍 DEBUG WORKFLOW

```
1. Problem dokumentieren
   - Was? Wo? Wann?
   
2. Logging hinzufügen
   error_log("DEBUG [v1.0]: $variable");
   
3. Iterativ fixen
   v1.0 → v1.1 → v1.2...
   
4. Lösung dokumentieren
   - Was war das Problem?
   - Wie wurde es gelöst?
```

---

## 📊 STATUS-REPORT STRUKTUR

```markdown
# Projekt Status Report

## ✅ Funktioniert
- Feature A (v1.2)

## 🔄 In Bearbeitung  
- Feature B (50%)

## ⚠️ Probleme
- Bug C: [Beschreibung]

## 🎯 Nächste Schritte
1. [Höchste Priorität]
```

**> 500 Zeilen?** → Archiv erstellen!

---

## 🔐 SECURITY QUICK-CHECK

```
□ Input Validation?
□ Prepared Statements?
□ XSS Protection?
□ CSRF Tokens?
□ .env für Secrets?
□ Error Display OFF?
```

---

## ⚙️ .ENV BASICS

```bash
# .env (NICHT in Git!)
APP_ENV=development
DB_DATABASE=/path/db.db
OLLAMA_HOST=http://ollama:11434
OLLAMA_MODEL=gemma2:2b
```

```php
// Laden
loadEnv('.env');
$value = getenv('DB_DATABASE');
```

---

## 📁 STANDARD STRUKTUR

```
/projekt/
├── /core/          # Kern-Code
├── /modules/       # Features
├── /assets/        # CSS, JS, Bilder
├── /database/      # DB-Dateien
├── /logs/          # Logs
├── /docker/        # Docker Config
├── .env            # Konfiguration
├── .gitignore
└── status_report.md
```

---

## 🎨 BRANDING (sgiT)

```css
--dark-green: #1A3503;
--neon-green: #43D240;
```

---

## 📞 SESSION ENDE

```
1. Status-Report aktualisieren
2. Git commit + push
3. Backup prüfen
4. TODOs notieren
```

---

## 🔗 QUICK LINKS

| Resource | URL |
|----------|-----|
| PHP Docs | php.net/docs.php |
| SQLite | sqlite.org/docs.html |
| Docker | docs.docker.com |
| Ollama | ollama.ai |
| OWASP | owasp.org |
| Git | git-scm.com/doc |

---

**sgiT Solution Engineering** | v1.2 | 2025-12-08
