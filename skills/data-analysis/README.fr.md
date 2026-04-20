🌐 [English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Türkçe](README.tr.md) | [中文](README.zh.md)

# Assistant d'Analyse de Données

**Analyse de données alimentée par l'IA utilisant l'API EvoLink**

Propulsé par [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)

Analysez des fichiers CSV, Excel et JSON avec une méthodologie axée sur la décision et une rigueur statistique.

## 🚀 Démarrage Rapide

```bash
bash scripts/analyze.sh sales_data.csv "Quels sont les principaux moteurs de revenus ?"
```

## 🔑 Configuration

Définissez votre clé API :

```bash
export EVOLINK_API_KEY="votre-clé"
```

👉 [Obtenir une clé API gratuite](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)

## 📖 Utilisation

### Analyse de Base

```bash
bash scripts/analyze.sh <chemin_fichier> "<question_analyse>"
```

**Formats supportés :**
- CSV (`.csv`)
- Excel (`.xlsx`, `.xls`)
- JSON (`.json`)

### Exemples de Questions

```bash
# Analyse de tendance
bash scripts/analyze.sh sales.csv "Quelle est la tendance mensuelle des revenus ?"

# Comparaison
bash scripts/analyze.sh experiment.csv "La variante A est-elle significativement meilleure que B ?"

# Segmentation
bash scripts/analyze.sh users.csv "Quels segments d'utilisateurs ont la meilleure rétention ?"

# Détection d'anomalies
bash scripts/analyze.sh metrics.csv "Y a-t-il des schémas inhabituels dans les 30 derniers jours ?"
```

## ⚙️ Configuration

| Variable | Défaut | Requis | Description |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Oui | Votre clé API Evolink. [Obtenez-en une gratuitement →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) |
| `EVOLINK_MODEL` | `[REDACTED]` | Non | Modèle pour l'analyse. Passez à n'importe quel modèle supporté par l'[API Evolink](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) |
| `DATA_ANALYSIS_SAFE_DIR` | `$HOME/.openclaw/workspace` | Non | Répertoire autorisé pour l'accès aux fichiers locaux |

Binaires requis : `curl`, `jq`, `python3`, `file`.

## 🎯 Principe Fondamental

**Une analyse sans décision n'est que de l'arithmétique.**

Cette compétence met l'accent sur :
- Méthodologie axée sur la décision
- Rigueur statistique (taille d'échantillon, intervalles de confiance, taille d'effet)
- Normes de sortie claires (priorité aux insights, incertitude quantifiée)
- Limitations et mises en garde explicites

## 📊 Ce Qu'il Fait

1. **Lit votre fichier de données** (CSV/Excel/JSON)
2. **Envoie à l'API EvoLink** avec votre question d'analyse
3. **Retourne des insights structurés** avec :
   - Résultats clés
   - Confiance statistique
   - Mises en garde et limitations
   - Prochaines étapes recommandées

## 🔒 Sécurité

**Identifiants & Réseau**

Nécessite `EVOLINK_API_KEY` pour appeler l'API EvoLink. Le contenu de votre fichier de données et la question d'analyse sont envoyés à `api.evolink.ai` pour traitement. EvoLink traite les données et retourne les résultats d'analyse. Aucune donnée n'est stockée après traitement.

**Accès aux Fichiers**

Lit le fichier de données spécifié depuis votre système de fichiers local. Les fichiers doivent être dans `DATA_ANALYSIS_SAFE_DIR` (par défaut : `$HOME/.openclaw/workspace`). Le script valide les chemins de fichiers et rejette les liens symboliques pour des raisons de sécurité.

Les chemins de fichiers sont résolus via `realpath -e` (nécessite que le fichier existe, résout tous les liens symboliques). Les entrées de liens symboliques sont explicitement rejetées.

Les fichiers sensibles sont sur liste noire par nom : `.env*`, `*.key`, `*.pem`, `*.p12`, `*.pfx`, `id_rsa*`, `authorized_keys`, `config.json`, `.bash_history`, `.ssh`, `shadow`, `passwd`.

**Limite de Taille de Fichier** : 50 Mo maximum pour les fichiers de données.

**Validation MIME** : Seuls `text/csv`, `text/plain`, `application/json`, `application/vnd.ms-excel`, `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet` sont acceptés.

**Accès Réseau**

- **API EvoLink** (`api.evolink.ai`) - Envoie les données et reçoit l'analyse

Tous les appels réseau utilisent curl et peuvent être audités dans le code source du script.

**Persistance & Privilèges**

Cette compétence ne modifie pas d'autres compétences ou paramètres système. Ne demande pas de permissions élevées ou persistantes.

## 📄 Licence

MIT

## 🔗 Liens

- [Référence API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)
- [Communauté](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
- [Obtenir une Clé API](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) — Inscription gratuite

Propulsé par [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)
