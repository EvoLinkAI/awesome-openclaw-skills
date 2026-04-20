# Gmail Assistant — Skill Email IA pour OpenClaw

Integration de l'API Gmail avec resume automatique par IA, redaction intelligente de reponses et priorisation de la boite de reception. Propulse par [evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail)

[Qu'est-ce que c'est ?](#quest-ce-que-cest-) | [Installation](#installation) | [Configuration](#guide-de-configuration) | [Utilisation](#utilisation) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail)

**Langue / Language:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Qu'est-ce que c'est ?

Gmail Assistant est un skill OpenClaw qui connecte votre compte Gmail a votre agent IA. Il offre un acces complet a l'API Gmail — lire, envoyer, rechercher, etiqueter, archiver — ainsi que des fonctionnalites IA comme le resume de la boite de reception, la redaction intelligente de reponses et la priorisation des emails via Claude et EvoLink.

**Les operations Gmail de base fonctionnent sans aucune cle API.** Les fonctionnalites IA (resume, redaction, priorisation) necessitent une cle API EvoLink optionnelle.

[Obtenez votre cle API EvoLink gratuite](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## Installation

### Installation Rapide

```bash
openclaw skills add https://github.com/EvoLinkAI/gmail-skill-for-openclaw
```

### Via ClawHub

```bash
npx clawhub install evolinkai/gmail
```

### Installation Manuelle

```bash
git clone https://github.com/EvoLinkAI/gmail-skill-for-openclaw.git
cd gmail-skill-for-openclaw
```

## Guide de Configuration

### Etape 1 : Creer des identifiants OAuth Google

1. Allez sur [Google Cloud Console](https://console.cloud.google.com/)
2. Creez un nouveau projet (ou selectionnez un projet existant)
3. Activez l'**API Gmail** : APIs & Services > Library > recherchez "Gmail API" > Enable
4. Configurez l'ecran de consentement OAuth : APIs & Services > OAuth consent screen > External > remplissez les champs requis
5. Creez des identifiants OAuth : APIs & Services > Credentials > Create Credentials > OAuth client ID > **Desktop app**
6. Telechargez le fichier `credentials.json`

### Etape 2 : Configurer

```bash
mkdir -p ~/.gmail-skill
cp credentials.json ~/.gmail-skill/credentials.json
bash scripts/gmail-auth.sh setup
```

### Etape 3 : Autoriser

```bash
bash scripts/gmail-auth.sh login
```

Cette commande ouvre un navigateur pour le consentement OAuth Google. Les jetons sont stockes localement dans `~/.gmail-skill/token.json`.

### Etape 4 : Definir la cle API EvoLink (Optionnel — pour les fonctionnalites IA)

```bash
export EVOLINK_API_KEY="your-key-here"
```

[Obtenez votre cle API](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## Utilisation

### Commandes de Base

```bash
# Lister les emails recents
bash scripts/gmail.sh list

# Lister avec un filtre
bash scripts/gmail.sh list --query "is:unread" --max 20

# Lire un email specifique
bash scripts/gmail.sh read MESSAGE_ID

# Envoyer un email
bash scripts/gmail.sh send "to@example.com" "Meeting tomorrow" "Hi, can we meet at 3pm?"

# Repondre a un email
bash scripts/gmail.sh reply MESSAGE_ID "Thanks, I'll be there."

# Rechercher des emails
bash scripts/gmail.sh search "from:boss@company.com has:attachment"

# Lister les libelles
bash scripts/gmail.sh labels

# Ajouter/supprimer un libelle
bash scripts/gmail.sh label MESSAGE_ID +STARRED
bash scripts/gmail.sh label MESSAGE_ID -UNREAD

# Marquer comme favori / Archiver / Supprimer
bash scripts/gmail.sh star MESSAGE_ID
bash scripts/gmail.sh archive MESSAGE_ID
bash scripts/gmail.sh trash MESSAGE_ID

# Voir le fil de discussion complet
bash scripts/gmail.sh thread THREAD_ID

# Informations du compte
bash scripts/gmail.sh profile
```

### Commandes IA (necessite EVOLINK_API_KEY)

```bash
# Resumer les emails non lus
bash scripts/gmail.sh ai-summary

# Resumer avec une requete personnalisee
bash scripts/gmail.sh ai-summary --query "from:team@company.com after:2026/04/01" --max 15

# Rediger une reponse par IA
bash scripts/gmail.sh ai-reply MESSAGE_ID "Politely decline and suggest next week"

# Prioriser la boite de reception
bash scripts/gmail.sh ai-prioritize --max 30
```

### Exemple de Sortie

```
Resume de la boite de reception (5 emails non lus) :

1. [URGENT] Date limite du projet avancee — de : manager@company.com
   La date de lancement du produit Q2 a ete avancee du 15 avril au 10 avril.
   Action requise : Mettre a jour le plan de sprint avant demain fin de journee.

2. Facture #4521 — de : billing@vendor.com
   Facture mensuelle d'abonnement SaaS de 299 $. Echeance le 15 avril.
   Action requise : Approuver ou transmettre au service financier.

3. Dejeuner d'equipe vendredi — de : hr@company.com
   Dejeuner de cohesion d'equipe a 12h30 vendredi. Confirmation souhaitee.
   Action requise : Repondre avec votre presence.

4. Newsletter : AI Weekly — de : newsletter@aiweekly.com
   Priorite basse. Resume hebdomadaire de l'actualite IA.
   Action requise : Aucune.

5. Notification GitHub — de : notifications@github.com
   PR #247 fusionnee dans main. CI reussie.
   Action requise : Aucune.
```

## Configuration

Binaires requis : `python3`, `curl`

| Variable | Par defaut | Requis | Description |
|----------|-----------|--------|-------------|
| `credentials.json` | — | Oui (principal) | Identifiants Google OAuth — consultez le [guide de configuration](#guide-de-configuration) |
| `EVOLINK_API_KEY` | — | Optionnel (IA) | Cle API EvoLink — [inscrivez-vous ici](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | Non | Modele IA — consultez la [documentation de l'API EvoLink](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail) |
| `GMAIL_SKILL_DIR` | `~/.gmail-skill` | Non | Chemin personnalise pour le stockage des identifiants |

## Syntaxe de Requete Gmail

- `is:unread` — Messages non lus
- `is:starred` — Messages favoris
- `from:user@example.com` — D'un expediteur specifique
- `to:user@example.com` — A un destinataire specifique
- `subject:keyword` — Le sujet contient un mot-cle
- `after:2026/01/01` — Apres une date
- `before:2026/12/31` — Avant une date
- `has:attachment` — Contient des pieces jointes
- `label:work` — Possede un libelle specifique

## Structure des Fichiers

```
.
├── README.md               # English (principal)
├── README.zh-CN.md         # 简体中文
├── README.ja.md            # 日本語
├── README.ko.md            # 한국어
├── README.es.md            # Español
├── README.fr.md            # Français
├── README.de.md            # Deutsch
├── README.tr.md            # Türkçe
├── README.ru.md            # Русский
├── SKILL.md                # Definition du skill OpenClaw
├── _meta.json              # Metadonnees du skill
├── LICENSE                 # Licence MIT
├── references/
│   └── api-params.md       # Reference des parametres de l'API Gmail
└── scripts/
    ├── gmail-auth.sh       # Gestionnaire d'authentification OAuth
    └── gmail.sh            # Operations Gmail + fonctionnalites IA
```

## Depannage

- **"Not authenticated"** — Executez `bash scripts/gmail-auth.sh login` pour vous autoriser
- **"credentials.json not found"** — Telechargez les identifiants OAuth depuis Google Cloud Console et placez-les dans `~/.gmail-skill/credentials.json`
- **"Token refresh failed"** — Votre jeton d'actualisation a peut-etre expire. Executez `bash scripts/gmail-auth.sh login` a nouveau
- **"Set EVOLINK_API_KEY"** — Les fonctionnalites IA necessitent une cle API EvoLink. Les operations Gmail de base fonctionnent sans cle
- **"Error 403: access_denied"** — Assurez-vous que l'API Gmail est activee dans votre projet Google Cloud et que l'ecran de consentement OAuth est configure
- **Securite des jetons** — Les jetons sont stockes avec les permissions `chmod 600`. Seul votre compte utilisateur peut les lire

## Liens

- [ClawHub](https://clawhub.ai/EvoLinkAI/gmail-assistant)
- [Reference API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail)
- [Communaute](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## Licence

MIT — voir [LICENSE](LICENSE) pour plus de details.
