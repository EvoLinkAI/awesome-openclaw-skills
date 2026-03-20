# Seedance 2 Video Gen Skill para OpenClaw

<p align="center">
  <strong>Generación de video con IA y más — instala en un comando, empieza a crear en segundos.</strong>
</p>

<p align="center">
  <a href="#generación-de-video-seedance">Seedance 2.0</a> •
  <a href="#instalación">Instalar</a> •
  <a href="#obtener-api-key">API Key</a> •
  <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=seedance2-video-gen-skill-for-openclaw">EvoLink</a>
</p>

<p align="center">
  <strong>🌐 Idiomas：</strong>
  <a href="README.md">English</a> |
  <a href="README.zh-CN.md">简体中文</a> |
  <a href="README.zh-TW.md">繁體中文</a> |
  <a href="README.es.md">Español</a> |
  <a href="README.ja.md">日本語</a> |
  <a href="README.ko.md">한국어</a> |
  <a href="README.tr.md">Türkçe</a> |
  <a href="README.fr.md">Français</a> |
  <a href="README.de.md">Deutsch</a>
</p>

---

## ¿Qué es esto?

Una colección de habilidades para [OpenClaw](https://github.com/openclaw/openclaw) impulsadas por [EvoLink](https://evolink.ai). Instala una habilidad y tu agente de IA gana nuevas capacidades — genera videos, procesa medios y más.

Disponible actualmente:

| Habilidad | Descripción | Modelo |
|-----------|-------------|--------|
| **Seedance Video Gen** | Texto a video e imagen a video con audio automático | Seedance 1.5 Pro → 2.0 (ByteDance) |

📚 **Guía Completa**: [awesome-seedance-2-guide](https://github.com/EvoLinkAI/awesome-seedance-2-guide) — Prompts, casos de uso y demostración de capacidades

🚀 **[Obtener Acceso Anticipado a Seedance 2.0 API →](https://seedance2api.app/)**

**Nota**: Actualmente usando Seedance 1.5 Pro. Cuando se lance Seedance 2.0, no se necesitará migración — funciona automáticamente.

Más habilidades próximamente.

---

## Instalación

### Instalación Rápida (Recomendado)

```bash
openclaw skills add https://github.com/EvoLinkAI/evolink-skills
```

Listo. La habilidad ya está disponible para tu agente.

### Instalación Manual

```bash
git clone https://github.com/EvoLinkAI/evolink-skills.git
cd evolink-skills
openclaw skills add .
```

---

## Obtener API Key

1. Regístrate en [evolink.ai](https://evolink.ai/signup?utm_source=github[evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=seedance2-video-gen-skill-for-openclaw)utm_medium=readme[evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=seedance2-video-gen-skill-for-openclaw)utm_campaign=seedance2-video-gen-skill-for-openclaw)
2. Ve a Dashboard → API Keys
3. Crea una nueva key
4. Configúrala en tu entorno:

```bash
export EVOLINK_API_KEY=tu_key_aquí
```

O dile a tu agente OpenClaw: *"Configura mi API key de EvoLink a ..."* — él se encargará del resto.

---

## Generación de Video Seedance

Genera videos de IA mediante conversación natural con tu agente OpenClaw.

### Qué Puede Hacer

- **Texto a video** — Describe una escena, obtén un video
- **Imagen a video** — Proporciona imágenes de referencia para guiar el resultado
- **Audio automático** — Voz, efectos de sonido y música de fondo sincronizados
- **Múltiples resoluciones** — 480p, 720p, 1080p
- **Duración flexible** — 4–12 segundos
- **Relaciones de aspecto** — 16:9, 9:16, 1:1, 4:3, 3:4, 21:9

### Ejemplos de Uso

Solo habla con tu agente:

> "Genera un video de 5 segundos de un gato tocando piano"

> "Crea un atardecer cinematográfico sobre el océano, 1080p, 16:9"

> "Usa esta imagen como referencia y anímala en un video de 8 segundos"

El agente te guiará a través de los detalles faltantes y manejará la generación.

### Requisitos

- `curl` y `jq` instalados en tu sistema
- Variable de entorno `EVOLINK_API_KEY` configurada

### Referencia de Script

La habilidad incluye `scripts/seedance-gen.sh` para uso directo en línea de comandos:

```bash
# Texto a video
./scripts/seedance-gen.sh "Un paisaje montañoso sereno al amanecer" --duration 5 --quality 720p

# Con imagen de referencia
./scripts/seedance-gen.sh "Suaves olas del océano" --image "https://example.com/beach.jpg" --duration 8 --quality 1080p

# Formato vertical para redes sociales
./scripts/seedance-gen.sh "Partículas bailando" --aspect-ratio 9:16 --duration 4 --quality 720p

# Sin audio
./scripts/seedance-gen.sh "Animación de arte abstracto" --duration 6 --quality 720p --no-audio
```

### Parámetros de API

Consulta [references/api-params.md](references/api-params.md) para documentación completa de la API.

---

## Estructura de Archivos

```
.
├── README.md                    # Este archivo
├── SKILL.md                     # Definición de habilidad OpenClaw
├── _meta.json                   # Metadatos de habilidad
├── references/
│   └── api-params.md            # Referencia completa de parámetros API
└── scripts/
    └── seedance-gen.sh          # Script de generación de video
```

---

## Solución de Problemas

| Problema | Solución |
|----------|----------|
| `jq: command not found` | Instala jq: `apt install jq` / `brew install jq` |
| `401 Unauthorized` | Verifica tu `EVOLINK_API_KEY` en [evolink.ai/dashboard](https://evolink.ai/dashboard) |
| `402 Payment Required` | Añade créditos en [evolink.ai/dashboard](https://evolink.ai/dashboard) |
| `Content blocked` | Rostros humanos realistas están restringidos — modifica tu prompt |
| Timeout de generación | Los videos pueden tardar 30–180s según configuración. Intenta menor calidad primero. |

---

## Más Habilidades

Estamos añadiendo más habilidades impulsadas por EvoLink. Mantente atento o [solicita una habilidad](https://github.com/EvoLinkAI/evolink-skills/issues).

---

## Descargar desde ClawHub

También puedes instalar esta habilidad directamente desde ClawHub:

👉 **[Descargar en ClawHub →](https://clawhub.ai/kn74p4xy6sja0199cea53anecs81kqjs/seedance-2-video-gen)**

---

## Licencia

MIT

---

<p align="center">
  Impulsado por <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=seedance2-video-gen-skill-for-openclaw"><strong>EvoLink</strong></a> — Gateway de API de IA Unificado
</p>
