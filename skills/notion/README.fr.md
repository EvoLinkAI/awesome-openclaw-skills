# Notion

🌐 [English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | Français | [Русский](README.ru.md)

Cette compétence permet aux agents d'interagir avec les pages et bases de données Notion via l'API Notion. Propulsé par Evolink AI pour un traitement intelligent du contenu.

## Démarrage Rapide
1. Créer une intégration Notion sur [notion.so/my-integrations](https://www.notion.so/my-integrations)
2. Copier le jeton d'intégration interne
3. Partager les pages/bases de données avec l'intégration
4. Configurer `NOTION_API_KEY` et `EVOLINK_API_KEY`
5. Installer : `clawhub install evolink-notion`

## Authentification

Exporter votre jeton Notion :
```bash
export NOTION_API_KEY=secret_xxx
```

**Important** : Vous devez partager les pages ou bases de données avec l'intégration. Le contenu non partagé est invisible pour l'API.

## Configuration

- `NOTION_API_KEY` : Jeton d'intégration Notion
- `EVOLINK_API_KEY` : Clé API pour les services Evolink AI. Obtenez votre clé gratuite sur [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=evolink-notion)

## Utilisation

**Lire une page :**
```bash
notion-cli page get <page_id>
```

**Ajouter du contenu :**
```bash
notion-cli block append <page_id> --markdown "..."
```

## Sécurité

- L'API Notion a des limites de débit
- Toujours confirmer avant les opérations destructives
- Le contenu traité via Evolink AI suit les pratiques standard de confidentialité des données

## Licence
MIT License

## Liens
- [Dépôt GitHub](https://clawhub.ai/EvoLinkAI/evolink-notion)
- [Documentation Evolink AI](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=evolink-notion)
- [Documentation API Notion](https://developers.notion.com)
- [Support Communautaire](https://discord.com/invite/5mGHfA24kn)
