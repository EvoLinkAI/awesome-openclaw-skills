# audio-analyze-skill-for-openclaw

Transcriba y analice contenido de audio/video con alta precisión. [Powered by Evolink.ai](https://evolink.ai/?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)

🌐 [English](README.md) | [日本語](README.ja.md) | [简体中文](README.zh-CN.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## ¿Qué es esto?

Transcriba y analice sus archivos de audio/video automáticamente usando Gemini 3.1 Pro. [Obtenga su clave API gratuita →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)

## Instalación

### Vía ClawHub (Recomendado)

```bash
openclaw skills add https://github.com/EvoLinkAI/audio-analyze-skill-for-openclaw
```

### Instalación Manual

```bash
git clone https://github.com/EvoLinkAI/audio-analyze-skill-for-openclaw
cd audio-analyze-skill-for-openclaw
pip install -r requirements.txt
```

## Configuración

| Variable | Descripción | Predeterminado |
| :--- | :--- | :--- |
| `EVOLINK_API_KEY` | Clave API de Evolink | (Requerido) |
| `EVOLINK_MODEL` | Modelo de Transcripción | gemini-3.1-pro-preview-customtools |

*Para configuración detallada de API y soporte de modelos, consulte la [Documentación de API de EvoLink](https://docs.evolink.ai/en/api-manual/language-series/gemini-3.1-pro-preview-customtools/openai-sdk/openai-sdk-quickstart?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze).*

## Uso

### Uso Básico

```bash
export EVOLINK_API_KEY="your-key-here"
./scripts/transcribe.sh audio.mp3
```

### Uso Avanzado

```bash
./scripts/transcribe.sh audio.mp3 --diarize --lang ja
```

### Ejemplo de Salida

* **TL;DR**: El audio es una pista de muestra para pruebas.
* **Puntos Clave**: Sonido de alta fidelidad, respuesta de frecuencia clara.
* **Elementos de Acción**: Subir a producción para pruebas finales.

## Modelos Disponibles

- **Serie Gemini** (OpenAI API — `/v1/chat/completions`)

## Estructura de Archivos

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

## Solución de Problemas

- **Argument list too long**: Use archivos temporales para datos de audio grandes.
- **API Key Error**: Asegúrese de que `EVOLINK_API_KEY` esté exportado.

## Enlaces

- [ClawHub](https://clawhub.ai/EvoLinkAI/audio-analyze)
- [Referencia de API](https://docs.evolink.ai/en/api-manual/language-series/gemini-3.1-pro-preview-customtools/openai-sdk/openai-sdk-quickstart?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)
- [Comunidad](https://discord.com/invite/5mGHfA24kn)
- [Soporte](mailto:support@evolink.ai)

## Licencia

MIT
