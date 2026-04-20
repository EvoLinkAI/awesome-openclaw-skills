# Humaniser le texte

[English](README.md) | [中文](README_zh.md) | [日本語](README_ja.md) | [한국어](README_ko.md) | [Русский](README_ru.md) | [हिन्दी](README_hi.md) | [Deutsch](README_de.md) | **Français** | [Italiano](README_it.md)

Supprimez les schémas d'écriture IA de n'importe quel texte. 29+ langues prises en charge.

Collez un article de blog, un e-mail, un essai ou un rapport — obtenez une version propre qui sonne comme écrite par un vrai humain.

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)

## Utilisation

Dites à votre agent :
- "Humanize this text"
- "Rends ce texte plus naturel"
- "Make this sound more natural"
- "Enlève le ton IA de ce paragraphe"

En ligne de commande :

```bash
bash scripts/humanize.sh "draft.txt"
bash scripts/humanize.sh "draft.txt" "casual blog post"
echo "Your text here" | bash scripts/humanize.sh -
```

## Comment ça marche

**Couche 1 — Scanner de patterns** : Détecte 24 schémas d'écriture IA courants dans le vocabulaire, la structure, le ton et le formatage.

**Couche 2 — Réécriture** : Remplace les expressions signalées par des alternatives naturelles, varie le rythme des phrases, supprime le remplissage.

**Couche 3 — Adaptation de style** : Ajuste le ton au contexte — blog, académique, e-mail professionnel, décontracté.

## Patterns détectés

| Catégorie | Exemples |
|---|---|
| Phrases de remplissage | « De plus », « Il convient de noter », « En résumé » |
| Langage promotionnel | « révolutionnaire », « incontournable », « unique » |
| Fausse profondeur | « mettant en lumière… reflétant… soulignant… » |
| Attributions vagues | « Selon les experts », « D'après les spécialistes » |
| Marqueurs structurels | Règle de trois, longueur de phrase uniforme |
| Vocabulaire IA | « extrêmement important », « sans couture », « robuste » |
| Artéfacts de chatbot | « J'espère que cela vous aide ! », « N'hésitez pas... » |

## Langues prises en charge

29+ langues dont l'anglais, le chinois, le japonais, le coréen, le russe, l'hindi, l'allemand, le français, l'italien, l'espagnol, le portugais, le néerlandais, le polonais, le turc, l'arabe et plus.

La langue est détectée automatiquement. Aucune configuration nécessaire.

## Exemple

**Avant** (style IA prononcé) :

> Cette mise à jour logicielle témoigne de l'engagement indéfectible de l'entreprise en faveur de l'innovation. De plus, elle offre une expérience utilisateur fluide, intuitive et robuste, garantissant que les utilisateurs puissent atteindre efficacement leurs objectifs.

**Après** :

> La mise à jour ajoute le traitement par lots, les raccourcis clavier et un mode hors ligne. L'interface est plus claire, la plupart des actions demandent moins de clics. Une amélioration concrète.

## Configuration

1. Obtenez une clé API sur [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize)
2. Définissez la variable d'environnement :

```bash
export EVOLINK_API_KEY="your-key-here"
```

## Liens

- [Code source](https://github.com/EvoLinkAI/text-humanizer-skill-for-openclaw) — GitHub
- [Documentation API (EN)](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize)
- [Obtenir une clé API](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize) — Inscription gratuite

## Licence

MIT

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)
