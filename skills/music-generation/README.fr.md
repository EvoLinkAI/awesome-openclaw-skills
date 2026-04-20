# Evolink Music — Skill de Génération Musicale IA pour OpenClaw

<p align="center">
  <strong>5 modèles musicaux, une clé API — Suno v4, v4.5, v5. Texte vers musique, paroles personnalisées, instrumental.</strong>
</p>

<p align="center">
  <a href="#quest-ce-que-cest">Quoi</a> •
  <a href="#installation">Installer</a> •
  <a href="#obtenir-une-api-key">API Key</a> •
  <a href="#génération-musicale">Générer</a> •
  <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw">EvoLink</a>
</p>

<p align="center">
  <strong>🌐 Langues:</strong>
  <a href="README.md">English</a> |
  <a href="README.zh-CN.md">简体中文</a> |
  <a href="README.es.md">Español</a> |
  <a href="README.ja.md">日本語</a> |
  <a href="README.ko.md">한국어</a> |
  <a href="README.fr.md">Français</a> |
  <a href="README.de.md">Deutsch</a> |
  <a href="README.tr.md">Türkçe</a> |
  <a href="README.zh-TW.md">繁體中文</a>
</p>

---

## Qu\'est-ce que c\'est ?

Un skill [OpenClaw](https://github.com/openclaw/openclaw) propulsé par [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=music-generation). Installez un skill et votre agent IA devient un studio musical — **5 modèles Suno** pour générer des chansons, instrumentaux et compositions personnalisées, le tout via une seule API.

| Skill | Description | Modèles |
|-------|-------------|---------|
| **Evolink Music** | Texte vers musique, paroles personnalisées, instrumental, contrôle vocal | Suno v4, v4.5, v4.5plus, v4.5all, v5 |

📚 **Guide Complet**: Génération musicale avec contrôle complet du style, genre, ambiance et structure.

---

## Installation

### Installation Rapide (Recommandé)

```bash
openclaw skills add https://github.com/EvoLinkAI/music-generation-skill-for-openclaw
```

C\'est tout ! Le skill est maintenant disponible pour votre agent.

### Installation Manuelle

```bash
git clone https://github.com/EvoLinkAI/music-generation-skill-for-openclaw.git
cd music-generation-skill-for-openclaw
openclaw skills add .
```

---

## Obtenir une API Key

1. Inscrivez-vous sur [evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_medium=readme[evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_campaign=music-generation-skill-for-openclaw)
2. Allez dans Dashboard → API Keys
3. Créez une nouvelle clé API
4. Configurez-la dans votre environnement:

```bash
export EVOLINK_API_KEY=votre_key_ici
```

---

## Génération Musicale

### Modèles Disponibles

| Modèle | Description | Cas d\'Usage |
|--------|-------------|--------------|
| **suno-v4** | Version stable, génération rapide | Pop, électronique, rock |
| **suno-v4.5** | Qualité supérieure, plus de détails | Production professionnelle |
| **suno-v4.5plus** | Qualité maximale, audio premium | Sorties commerciales |
| **suno-v4.5all** | Polyvalence complète | Tous les genres |
| **suno-v5** | Dernière version, capacités avancées | Expérimentation créative |

### Fonctionnalités

- **5 modèles** avec différentes capacités
- **Contrôle de style** — genre, ambiance, tempo, intensité
- **Paroles personnalisées** — écrivez les vôtres ou laissez l\'IA les générer
- **Mode instrumental** — musique sans voix
- **Contrôle vocal** — ajustez le type de voix et la gamme

### Exemples d\'Utilisation

Parlez à votre agent:

> "Génère une chanson pop joyeuse sur l\'été avec guitare acoustique"

> "Crée de la musique jazz instrumentale, 3 minutes, ambiance relaxante"

> "Écris une chanson rock avec paroles personnalisées sur les road trips"

---

## Dépannage

| Problème | Solution |
|----------|----------|
| `401 Unauthorized` | Vérifiez votre `EVOLINK_API_KEY` sur [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation) |
| `402 Payment Required` | Ajoutez des crédits sur [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation) |
| `429 Rate Limited` | Trop de requêtes — attendez un moment |

---

## Licence

MIT

---

<p align="center">
  Propulsé par <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw"><strong>EvoLink</strong></a> — Passerelle API IA Unifiée
</p>
