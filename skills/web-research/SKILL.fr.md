---
name: web-research
description: Recherche web via l'API EvoLink. Renvoie des résultats propres et formatés avec titres, URLs et descriptions. Powered by evolink.ai
metadata: {"clawdbot":{"emoji":"🔍","requires":{"bins":["bash","curl","jq"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# Web Search Assistant

Recherche web utilisant l'API EvoLink. Renvoie des résultats propres et formatés avec titres, URLs et descriptions.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## Quand l'utiliser

Utilisez ce skill lorsque les utilisateurs demandent :
- Des recherches web pour des informations ou des ressources
- Trouver des informations actuelles ou récentes en ligne
- Des recherches nécessitant des données web actuelles
- Vérification de faits ou validation à l'aide de sources web
- Rassembler des URLs et des ressources sur un sujet

## Recherche

```bash
{baseDir}/scripts/search.sh "requête"
{baseDir}/scripts/search.sh "requête" 20
```

## Options

- `<query>` : Requête de recherche
- `<max_results>` : Nombre de résultats (par défaut : 10)

## Configuration

Définissez votre clé API EvoLink :

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [Obtenir une clé API gratuite](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## Exemple

```bash
bash scripts/search.sh "Claude Opus 4 features"
```

Sortie :
```
🔍 Recherche : Claude Opus 4 features

📄 Claude Opus 4: New Features and Capabilities
🔗 https://example.com/opus-4
📝 Comprehensive guide to Claude Opus 4's new features...

📄 What's New in Claude Opus 4
🔗 https://example.com/whats-new
📝 Latest updates and improvements in Claude Opus 4...
```

## Sécurité

**Identifiants et réseau**

`EVOLINK_API_KEY` est requis pour appeler l'API EvoLink. Vos requêtes de recherche sont envoyées à `api.evolink.ai` pour traitement. EvoLink gère la recherche web en interne et renvoie des résultats formatés.

**Accès aux fichiers**

Ce skill ne lit ni n'écrit de fichiers.

**Accès réseau**

Ce skill effectue des requêtes réseau vers :
- **API EvoLink** (`api.evolink.ai`) - pour effectuer des recherches web

Tous les appels réseau sont effectués via curl et peuvent être audités dans le code source du script.

**Persistance et privilèges**

Ce skill ne modifie pas d'autres skills ou paramètres système. Aucun privilège élevé ou persistant n'est demandé.

## Liens

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [Référence API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)
- [Communauté](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
