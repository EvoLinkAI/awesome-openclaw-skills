# Gmail Assistant — Skill de Email con IA para OpenClaw

Integracion con la API de Gmail con resumen impulsado por IA, redaccion inteligente de respuestas y priorizacion de la bandeja de entrada. Desarrollado por [evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail)

[Que es esto?](#que-es-esto) | [Instalacion](#instalacion) | [Configuracion](#guia-de-configuracion) | [Uso](#uso) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail)

**Language / Idioma:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Que es esto?

Gmail Assistant es un skill de OpenClaw que conecta tu cuenta de Gmail con tu agente de IA. Proporciona acceso completo a la API de Gmail — leer, enviar, buscar, etiquetar, archivar — ademas de funciones impulsadas por IA como resumen de la bandeja de entrada, redaccion inteligente de respuestas y priorizacion de correos usando Claude a traves de EvoLink.

**Las operaciones basicas de Gmail funcionan sin ninguna clave API.** Las funciones de IA (resumir, redactar, priorizar) requieren una clave API de EvoLink opcional.

[Obtener tu clave API gratuita de EvoLink](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## Instalacion

### Instalacion Rapida

```bash
openclaw skills add https://github.com/EvoLinkAI/gmail-skill-for-openclaw
```

### Mediante ClawHub

```bash
npx clawhub install evolinkai/gmail
```

### Instalacion Manual

```bash
git clone https://github.com/EvoLinkAI/gmail-skill-for-openclaw.git
cd gmail-skill-for-openclaw
```

## Guia de Configuracion

### Paso 1: Crear Credenciales de Google OAuth

1. Ve a [Google Cloud Console](https://console.cloud.google.com/)
2. Crea un nuevo proyecto (o selecciona uno existente)
3. Habilita la **Gmail API**: APIs & Services > Library > busca "Gmail API" > Enable
4. Configura la pantalla de consentimiento OAuth: APIs & Services > OAuth consent screen > External > completa los campos requeridos
5. Crea las credenciales OAuth: APIs & Services > Credentials > Create Credentials > OAuth client ID > **Desktop app**
6. Descarga el archivo `credentials.json`

### Paso 2: Configurar

```bash
mkdir -p ~/.gmail-skill
cp credentials.json ~/.gmail-skill/credentials.json
bash scripts/gmail-auth.sh setup
```

### Paso 3: Autorizar

```bash
bash scripts/gmail-auth.sh login
```

Esto abre un navegador para el consentimiento de Google OAuth. Los tokens se almacenan localmente en `~/.gmail-skill/token.json`.

### Paso 4: Configurar Clave API de EvoLink (Opcional — para funciones de IA)

```bash
export EVOLINK_API_KEY="tu-clave-aqui"
```

[Obtener tu clave API](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## Uso

### Comandos Principales

```bash
# Listar correos recientes
bash scripts/gmail.sh list

# Listar con filtro
bash scripts/gmail.sh list --query "is:unread" --max 20

# Leer un correo especifico
bash scripts/gmail.sh read MESSAGE_ID

# Enviar un correo
bash scripts/gmail.sh send "to@example.com" "Reunion manana" "Hola, podemos reunirnos a las 3pm?"

# Responder a un correo
bash scripts/gmail.sh reply MESSAGE_ID "Gracias, ahi estare."

# Buscar correos
bash scripts/gmail.sh search "from:boss@company.com has:attachment"

# Listar etiquetas
bash scripts/gmail.sh labels

# Agregar/quitar etiqueta
bash scripts/gmail.sh label MESSAGE_ID +STARRED
bash scripts/gmail.sh label MESSAGE_ID -UNREAD

# Destacar / Archivar / Papelera
bash scripts/gmail.sh star MESSAGE_ID
bash scripts/gmail.sh archive MESSAGE_ID
bash scripts/gmail.sh trash MESSAGE_ID

# Ver hilo completo
bash scripts/gmail.sh thread THREAD_ID

# Informacion de la cuenta
bash scripts/gmail.sh profile
```

### Comandos de IA (requiere EVOLINK_API_KEY)

```bash
# Resumir correos no leidos
bash scripts/gmail.sh ai-summary

# Resumir con consulta personalizada
bash scripts/gmail.sh ai-summary --query "from:team@company.com after:2026/04/01" --max 15

# Redactar una respuesta con IA
bash scripts/gmail.sh ai-reply MESSAGE_ID "Declinar amablemente y sugerir la proxima semana"

# Priorizar bandeja de entrada
bash scripts/gmail.sh ai-prioritize --max 30
```

### Ejemplo de Salida

```
Resumen de la Bandeja de Entrada (5 correos no leidos):

1. [URGENTE] Fecha limite del proyecto adelantada — de: manager@company.com
   La fecha limite del lanzamiento del producto Q2 se adelanto del 15 de abril al 10 de abril.
   Accion necesaria: Actualizar el plan del sprint antes del final del dia de manana.

2. Factura #4521 — de: billing@vendor.com
   Factura mensual de suscripcion SaaS por $299. Vence el 15 de abril.
   Accion necesaria: Aprobar o reenviar a finanzas.

3. Almuerzo de equipo el viernes — de: hr@company.com
   Almuerzo de integracion del equipo a las 12:30 PM el viernes. Se solicita confirmacion de asistencia.
   Accion necesaria: Responder con confirmacion de asistencia.

4. Boletin: AI Weekly — de: newsletter@aiweekly.com
   Prioridad baja. Resumen semanal de noticias de IA.
   Accion necesaria: Ninguna.

5. Notificacion de GitHub — de: notifications@github.com
   PR #247 fusionado a main. CI aprobado.
   Accion necesaria: Ninguna.
```

## Configuracion

Binarios requeridos: `python3`, `curl`

| Variable | Predeterminado | Requerido | Descripcion |
|----------|---------------|-----------|-------------|
| `credentials.json` | — | Si (principal) | Credenciales de Google OAuth — consulta la [guia de configuracion](#guia-de-configuracion) |
| `EVOLINK_API_KEY` | — | Opcional (IA) | Clave API de EvoLink — [registrate aqui](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | Modelo de IA — consulta la [documentacion de la API de EvoLink](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail) |
| `GMAIL_SKILL_DIR` | `~/.gmail-skill` | No | Ruta personalizada para almacenamiento de credenciales |

## Sintaxis de Consultas de Gmail

- `is:unread` — Mensajes no leidos
- `is:starred` — Mensajes destacados
- `from:user@example.com` — De un remitente especifico
- `to:user@example.com` — Para un destinatario especifico
- `subject:keyword` — El asunto contiene una palabra clave
- `after:2026/01/01` — Despues de una fecha
- `before:2026/12/31` — Antes de una fecha
- `has:attachment` — Tiene archivos adjuntos
- `label:work` — Tiene una etiqueta especifica

## Estructura de Archivos

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
├── SKILL.md                # Definicion del skill de OpenClaw
├── _meta.json              # Metadatos del skill
├── LICENSE                 # Licencia MIT
├── references/
│   └── api-params.md       # Referencia de parametros de la API de Gmail
└── scripts/
    ├── gmail-auth.sh       # Gestor de autenticacion OAuth
    └── gmail.sh            # Operaciones de Gmail + funciones de IA
```

## Solucion de Problemas

- **"Not authenticated"** — Ejecuta `bash scripts/gmail-auth.sh login` para autorizar
- **"credentials.json not found"** — Descarga las credenciales OAuth desde Google Cloud Console y colocalas en `~/.gmail-skill/credentials.json`
- **"Token refresh failed"** — Tu token de actualizacion puede haber expirado. Ejecuta `bash scripts/gmail-auth.sh login` de nuevo
- **"Set EVOLINK_API_KEY"** — Las funciones de IA requieren una clave API de EvoLink. Las operaciones basicas de Gmail funcionan sin ella
- **"Error 403: access_denied"** — Asegurate de que la Gmail API este habilitada en tu proyecto de Google Cloud y que la pantalla de consentimiento OAuth este configurada
- **Seguridad de tokens** — Los tokens se almacenan con permisos `chmod 600`. Solo tu cuenta de usuario puede leerlos

## Enlaces

- [ClawHub](https://clawhub.ai/EvoLinkAI/gmail-assistant)
- [Referencia de la API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail)
- [Comunidad](https://discord.com/invite/5mGHfA24kn)
- [Soporte](mailto:support@evolink.ai)

## Licencia

MIT — consulta [LICENSE](LICENSE) para mas detalles.
