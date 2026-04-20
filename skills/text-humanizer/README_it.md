# Umanizzare il testo

[English](README.md) | [中文](README_zh.md) | [日本語](README_ja.md) | [한국어](README_ko.md) | [Русский](README_ru.md) | [हिन्दी](README_hi.md) | [Deutsch](README_de.md) | [Français](README_fr.md) | **Italiano**

Rimuovi i pattern di scrittura AI da qualsiasi testo. Supporto per 29+ lingue.

Incolla un articolo di blog, un'e-mail, un saggio o un report — ottieni una versione pulita che suona come scritta da una persona vera.

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)

## Come usarlo

Dì al tuo agente:
- "Humanize this text"
- "Rendi questo testo più naturale"
- "Make this sound more natural"
- "Togli il tono AI da questo paragrafo"

Da riga di comando:

```bash
bash scripts/humanize.sh "draft.txt"
bash scripts/humanize.sh "draft.txt" "casual blog post"
echo "Your text here" | bash scripts/humanize.sh -
```

## Come funziona

**Livello 1 — Scanner di pattern**: Rileva 24 pattern comuni di scrittura AI nel vocabolario, nella struttura, nel tono e nella formattazione.

**Livello 2 — Riscrittura**: Sostituisce le espressioni segnalate con alternative naturali, varia il ritmo delle frasi, taglia il superfluo.

**Livello 3 — Adattamento di stile**: Adatta il tono al contesto — blog, accademico, e-mail di lavoro, informale.

## Pattern rilevati

| Categoria | Esempi |
|---|---|
| Frasi di riempimento | "Inoltre", "Vale la pena notare", "In sintesi" |
| Linguaggio promozionale | "rivoluzionario", "fondamentale", "ineguagliabile" |
| Falsa profondità | "evidenziando… riflettendo… mettendo in luce…" |
| Attribuzioni vaghe | "Secondo gli esperti", "Gli analisti ritengono" |
| Segnali strutturali | Regola del tre, lunghezza uniforme delle frasi |
| Vocabolario AI | "estremamente importante", "senza soluzione di continuità", "robusto" |
| Artefatti chatbot | "Spero che sia utile!", "Non esitare a chiedere..." |

## Lingue supportate

29+ lingue tra cui inglese, cinese, giapponese, coreano, russo, hindi, tedesco, francese, italiano, spagnolo, portoghese, olandese, polacco, turco, arabo e altre.

La lingua viene rilevata automaticamente. Nessuna configurazione necessaria.

## Esempio

**Prima** (forte stile AI):

> Questo aggiornamento software rappresenta una testimonianza dell'impegno incrollabile dell'azienda verso l'innovazione. Inoltre, offre un'esperienza utente fluida, intuitiva e robusta, garantendo che gli utenti possano raggiungere efficientemente i propri obiettivi.

**Dopo**:

> L'aggiornamento aggiunge elaborazione batch, scorciatoie da tastiera e modalità offline. L'interfaccia è più chiara, la maggior parte delle operazioni richiede meno clic. Un miglioramento concreto.

## Configurazione

1. Ottieni una chiave API su [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize)
2. Imposta la variabile d'ambiente:

```bash
export EVOLINK_API_KEY="your-key-here"
```

## Link

- [Codice sorgente](https://github.com/EvoLinkAI/text-humanizer-skill-for-openclaw) — GitHub
- [Documentazione API (EN)](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize)
- [Ottieni chiave API](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize) — Registrazione gratuita

## Licenza

MIT

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)
