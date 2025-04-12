# Dotfiles-Repository Installation

Dieses Repository enthält Konfigurationsdateien und Installationsskripte für Fedora und macOS. Die Installation erfolgt entweder direkt über `chezmoi` oder mithilfe der bereitgestellten Skripte.

## Voraussetzungen
- **Git** ([Installationsanleitung](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git))
- **curl** (meist vorinstalliert)
- Terminal mit Administratorrechten

---

## Installation

### Methode 1: Direkte Installation mit chezmoi
Führen Sie diese Befehle **nacheinander** aus:

```
# 1. Chezmoi installieren
sh -c "$(curl -fsLS get.chezmoi.io)"

# 2. Dotfiles anwenden
chezmoi init -v --apply --force https://code.brothertec.eu/simono41/dotfiles.git
```

### Methode 2: Systemspezifische Skripte
**Fedora:**
```
chmod +x install-fedora.sh && ./install-fedora.sh
```

**macOS:**
```
chmod +x install-macos.sh && ./install-macos.sh
```

---

## Features der Skripte
- **Automatische OS-Erkennung**  
  Abbruch bei falschem Betriebssystem
- **Redundanzprüfung**  
  Überspringt bereits installierte Komponenten:
  - Chezmoi
  - Starship
  - Cliphist
- **Kategorisierte Paketgruppen**  
  Klare Trennung von:
  - Shell-Tools
  - GUI-Komponenten
  - Entwicklungsumgebungen
  - Systemdiensten

---

## Post-Installation
- **ZSH als Standard-Shell**  
  Wird automatisch gesetzt
- **Flatpak-Repository**  
  Flathub wird hinzugefügt
- **Architekturspezifische Binärdateien**  
  Automatische Auswahl zwischen ARM/x86_64

---

## Skript-Funktionen im Detail
| Feature                  | Fedora-Skript | macOS-Skript |
|--------------------------|---------------|--------------|
| Paketmanager-Installation| DNF           | Homebrew     |
| Virtulisierung           | @virtualization | Docker      |
| Clipboard-Manager        | cliphist      | flycut       |
| Terminal-Emulator        | Wezterm       | Wezterm      |

---

## Beitragende
- Simon Rieger ([GitHub](https://github.com/simono41))

---

## Lizenz
MIT-Lizenz – Details siehe [LICENSE](LICENSE)

---

**Hinweis:** Bei Verwendung der curl-Methode wird empfohlen, das Skript vor der Ausführung zu überprüfen.
