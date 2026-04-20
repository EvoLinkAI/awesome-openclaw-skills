# Evolink Music — Skill de Generación Musical AI para OpenClaw

<p align="center">
  <strong>5 modelos musicales, una API key — Suno v4, v4.5, v5. Texto a música, letras personalizadas, instrumental.</strong>
</p>

<p align="center">
  <a href="#qué-es-esto">Qué</a> •
  <a href="#instalación">Instalar</a> •
  <a href="#obtener-api-key">API Key</a> •
  <a href="#generación-musical">Generar</a> •
  <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw">EvoLink</a>
</p>

<p align="center">
  <strong>🌐 Idiomas:</strong>
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

## ¿Qué es esto?

Un skill de [OpenClaw](https://github.com/openclaw/openclaw) impulsado por [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=music-generation). Instala un skill y tu agente de IA se convierte en un estudio musical — **5 modelos Suno** para generar canciones, instrumentales y composiciones personalizadas, todo a través de una sola API.

| Skill | Descripción | Modelos |
|-------|-------------|---------|
| **Evolink Music** | Texto a música, letras personalizadas, instrumental, control vocal | Suno v4, v4.5, v4.5plus, v4.5all, v5 |

📚 **Guía Completa**: Generación musical con control completo de estilo, género, humor y estructura.

---

## Instalación

### Instalación Rápida (Recomendado)

```bash
openclaw skills add https://github.com/EvoLinkAI/music-generation-skill-for-openclaw
```

¡Listo! El skill ahora está disponible para tu agente.

### Instalación Manual

```bash
git clone https://github.com/EvoLinkAI/music-generation-skill-for-openclaw.git
cd music-generation-skill-for-openclaw
openclaw skills add .
```

---

## Obtener API Key

1. Regístrate en [evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_medium=readme[evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_campaign=music-generation-skill-for-openclaw)
2. Ve a Dashboard → API Keys
3. Crea una nueva API key
4. Configúrala en tu entorno:

```bash
export EVOLINK_API_KEY=tu_key_aquí
```

---

## Generación Musical

### Modelos Disponibles

| Modelo | Descripción | Casos de Uso |
|--------|-------------|--------------|
| **suno-v4** | Versión estable, generación rápida | Música pop, electrónica, rock |
| **suno-v4.5** | Mayor calidad, más detalles | Producción profesional |
| **suno-v4.5plus** | Máxima calidad, audio premium | Lanzamientos comerciales |
| **suno-v4.5all** | Versatilidad completa | Todos los géneros |
| **suno-v5** | Última versión, capacidades avanzadas | Experimentación creativa |

### Características

- **5 modelos** con diferentes capacidades
- **Control de estilo** — género, humor, tempo, intensidad
- **Letras personalizadas** — escribe tus propias letras o deja que la IA las genere
- **Modo instrumental** — música sin vocales
- **Control vocal** — ajusta el tipo de voz y rango

### Ejemplos de Uso

Habla con tu agente:

> "Genera una canción pop alegre sobre verano con guitarra acústica"

> "Crea música de jazz instrumental, 3 minutos, ambiente relajante"

> "Escribe una canción rock con letras personalizadas sobre viajes por carretera"

---

## Solución de Problemas

| Problema | Solución |
|----------|----------|
| `401 Unauthorized` | Verifica tu `EVOLINK_API_KEY` en [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation) |
| `402 Payment Required` | Añade créditos en [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation) |
| `429 Rate Limited` | Demasiadas solicitudes — espera un momento |

---

## Licencia

MIT

---

<p align="center">
  Impulsado por <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw"><strong>EvoLink</strong></a> — Gateway de API de IA Unificado
</p>
