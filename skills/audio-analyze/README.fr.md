# audio-analyze-skill-for-openclaw

Transcrivez et analysez du contenu audio/vidéo avec une grande précision. [Powered by Evolink.ai](https://evolink.ai/?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)

🌐 [English](README.md) | [日本語](README.ja.md) | [简体中文](README.zh-CN.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Qu'est-ce que c'est ?

Transcrivez et analysez automatiquement vos fichiers audio/vidéo en utilisant Gemini 3.1 Pro. [Obtenez votre clé API gratuite →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)

## Installation

### Via ClawHub (Recommandé)

```bash
openclaw skills add https://github.com/EvoLinkAI/audio-analyze-skill-for-openclaw
```

### Installation Manuelle

```bash
git clone https://github.com/EvoLinkAI/audio-analyze-skill-for-openclaw
cd audio-analyze-skill-for-openclaw
pip install -r requirements.txt
```

## Configuration

| Variable | Description | Défaut |
| :--- | :--- | :--- |
| `EVOLINK_API_KEY` | Clé API Evolink | (Requis) |
| `EVOLINK_MODEL` | Modèle de Transcription | gemini-3.1-pro-preview-customtools |

*Pour une configuration détaillée de l'API et le support des modèles, consultez la [Documentation API EvoLink](https://docs.evolink.ai/en/api-manual/language-series/gemini-3.1-pro-preview-customtools/openai-sdk/openai-sdk-quickstart?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze).*

## Utilisation

### Utilisation de Base

```bash
export EVOLINK_API_KEY="your-key-here"
./scripts/transcribe.sh audio.mp3
```

### Utilisation Avancée

```bash
./scripts/transcribe.sh audio.mp3 --diarize --lang ja
```

### Exemple de Sortie

* **TL;DR**: L'audio est une piste d'exemple pour les tests.
* **Points Clés**: Son haute fidélité, réponse en fréquence claire.
* **Actions à Entreprendre**: Télécharger en production pour les tests finaux.

## Modèles Disponibles

- **Série Gemini** (OpenAI API — `/v1/chat/completions`)

## Structure des Fichiers

```
.
├── README.md
├── SKILL.md
├── _meta.json
├── scripts/
│   └── transcribe.sh
└── references/
    └── api-params.md
```

## Dépannage

- **Argument list too long**: Utilisez des fichiers temporaires pour les données audio volumineuses.
- **API Key Error**: Assurez-vous que `EVOLINK_API_KEY` est exporté.

## Liens

- [ClawHub](https://clawhub.ai/EvoLinkAI/audio-analyze)
- [Référence API](https://docs.evolink.ai/en/api-manual/language-series/gemini-3.1-pro-preview-customtools/openai-sdk/openai-sdk-quickstart?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)
- [Communauté](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## Licence

MIT
