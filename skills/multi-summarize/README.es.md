# Multi Summarize — Skill de Resumen con IA para OpenClaw

Resumen rápido multiformato — pega una URL, suelta un archivo y obtén los puntos clave. Desarrollado por [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize).

 [Qué es](#qué-es) •
 [Instalación](#instalación) •
 [API Key](#obtener-api-key) •
 [Uso](#uso) •
 [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)

 🌐 Languages:
 [English](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.md) |
 [简体中文](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.zh-CN.md) |
 [日本語](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.ja.md) |
 [한국어](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.ko.md) |
 [Español](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.es.md) |
 [Français](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.fr.md) |
 [Deutsch](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.de.md) |
 [Türkçe](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.tr.md) |
 [Русский](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.ru.md)

## Qué es

Un skill de [OpenClaw](https://github.com/openclaw/openclaw) desarrollado por [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize). Instala un solo skill y tu agente de IA podrá resumir cualquier contenido — URLs, PDFs, vídeos, archivos de audio, enlaces de YouTube o texto plano — en puntos clave concisos y accionables usando Claude Opus 4.6, el modelo de texto más potente disponible.

🚀 [Obtén tu API Key →](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)

## Instalación

### Instalación rápida (Recomendada)

```bash
openclaw skills add https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw
```

Listo. El skill está preparado para tu agente.

### Vía ClawHub

```bash
clawhub install multi-summarize
```

### Instalación manual

```bash
git clone https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw.git
cd multi-summarize-skill-for-openclaw
openclaw skills add .
```

## Obtener API Key

1. Regístrate [aquí](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)
2. Ve a Dashboard → API Keys
3. Crea una nueva Key
4. Configura la variable de entorno:

```bash
export EVOLINK_API_KEY=your_key_here
```

O simplemente dile a tu agente OpenClaw: "Configura mi EvoLink API key a ..." — él se encargará del resto.

## Uso

### Formatos soportados

- **URLs web** — Artículos, blogs, documentación
- **PDF** — Informes, papers, whitepapers
- **Vídeo** — mp4, webm, enlaces de YouTube
- **Audio** — mp3, wav, m4a, podcasts
- **Texto** — Markdown, texto plano, archivos de código

### Ejemplos de uso

Habla con tu agente de forma natural:

```
"Resume este artículo: https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize"
"¿De qué trata este PDF?" (adjunta archivo)
"Dame los puntos clave de este vídeo de YouTube: https://youtu.be/..."
"Resume esta grabación de podcast" (adjunta mp3)
"Dame un TL;DR de este documento"
```

### Referencia del script

El skill incluye `scripts/summarize.sh` para uso directo en línea de comandos:

```bash
# Resumir un artículo web
bash scripts/summarize.sh "https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize"

# Resumir un PDF local
bash scripts/summarize.sh "/path/to/report.pdf"

# Resumir un vídeo de YouTube
bash scripts/summarize.sh "https://youtu.be/VIDEO_ID"

# Resumir un archivo de audio
bash scripts/summarize.sh "/path/to/podcast.mp3"

# Resumir con enfoque personalizado
bash scripts/summarize.sh "https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize" "Enfócate en la línea temporal de lanzamiento"
```

### Ejemplo de salida

```
## TL;DR
DeepSeek V4 ha sido rumoreado desde enero de 2026 pero aún no se ha lanzado
oficialmente a fecha de marzo. Múltiples ventanas de lanzamiento previstas han pasado.
Se espera que el modelo se enfoque en programación con puntuaciones HumanEval del 90% (sin verificar).

## Puntos clave
- Reuters informó en enero que DeepSeek planea un modelo enfocado en programación para febrero de 2026
- DeepSeek expandió silenciosamente el contexto de 128K a 1M tokens en febrero — probable prueba de infraestructura V4
- Benchmarks no verificados afirman HumanEval 90%, SWE-bench Verified 80%+
- "V4 Lite" apareció en el sitio de DeepSeek en marzo pero nunca fue confirmado oficialmente
- Múltiples ventanas de lanzamiento (mediados de febrero, Año Nuevo Lunar, principios de marzo) pasaron sin lanzamiento

## Acciones recomendadas
- No migrar cargas de trabajo de producción hasta el anuncio oficial
- Monitorear los canales oficiales de DeepSeek para especificaciones confirmadas
- Preparar la integración API — EvoLink soportará V4 desde el primer día
```

## Configuración

Modelo por defecto: `claude-opus-4-6` (no requiere configuración adicional).

Para usar un modelo diferente:

```bash
export EVOLINK_MODEL="claude-sonnet-4-5-20250929"
```

### Modelos disponibles

**Serie Claude** (formato API Anthropic — `/v1/messages`)
- **claude-opus-4-6** — Máxima calidad (por defecto)
- **claude-sonnet-4-6** — Último Sonnet, rápido + potente
- **claude-sonnet-4-5-20250929** — Rápido + económico
- **claude-haiku-4-5-20251001** — Ultra rápido, tareas ligeras

**Serie GPT** (formato API OpenAI — `/v1/chat/completions`)
- **gpt-5.4** — Último modelo insignia de OpenAI
- **gpt-4o** — Multimodal, rápido
- **gpt-4o-mini** — Ligero, económico

**Serie Gemini** (formato API OpenAI — `/v1/chat/completions`)
- **gemini-3.1-flash-lite-preview** — Modelo ultra rápido y ligero de Google
- **gemini-3-flash-preview** — Rápido, ideal para resúmenes

### Referencia API

Documentación completa de la API [aquí](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize).

## Estructura de archivos

```
.
├── README.md              # English
├── README.zh-CN.md        # 简体中文
├── README.ja.md           # 日本語
├── README.ko.md           # 한국어
├── README.es.md           # Español
├── README.fr.md           # Français
├── README.de.md           # Deutsch
├── README.tr.md           # Türkçe
├── README.ru.md           # Русский
├── SKILL.md               # OpenClaw skill definition
├── references/
│   └── api-params.md      # Full API parameter docs
└── scripts/
    └── summarize.sh       # Summarization script
```

## Solución de problemas

- **`python3: command not found`** — Instalar Python 3: `apt install python3` / `brew install python3`
- **`curl: command not found`** — Instalar curl: `apt install curl` / `brew install curl`
- **`401 Unauthorized`** — Verifica EVOLINK_API_KEY en tu [panel de control](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)
- **`402 Payment Required`** — Recarga en tu [panel de control](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)
- **Fallo en extracción de PDF** — Instalar markitdown: `pip install markitdown` o poppler: `apt install poppler-utils`
- **Fallo en extracción de YouTube** — Instalar yt-dlp: `pip install yt-dlp`
- **Fallo en transcripción de audio** — Instalar whisper: `pip install openai-whisper`

## Enlaces

- [ClawHub](https://clawhub.ai/EvoLinkAI/multi-summarize)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## Licencia

MIT
