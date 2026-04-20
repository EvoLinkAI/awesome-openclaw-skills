# Notion

🌐 [English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | Español | [Français](README.fr.md) | [Русский](README.ru.md)

Esta habilidad permite a los agentes interactuar con páginas y bases de datos de Notion usando la API de Notion. Potenciado por Evolink AI para procesamiento inteligente de contenido.

## Inicio Rápido
1. Crear una integración de Notion en [notion.so/my-integrations](https://www.notion.so/my-integrations)
2. Copiar el token de integración interno
3. Compartir páginas/bases de datos con la integración
4. Configurar `NOTION_API_KEY` y `EVOLINK_API_KEY`
5. Instalar: `clawhub install evolink-notion`

## Autenticación

Exportar tu token de Notion:
```bash
export NOTION_API_KEY=secret_xxx
```

**Importante**: Debes compartir las páginas o bases de datos con la integración. El contenido no compartido es invisible para la API.

## Configuración

- `NOTION_API_KEY`: Token de integración de Notion
- `EVOLINK_API_KEY`: Clave API para servicios de Evolink AI. Obtén tu clave gratuita en [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=evolink-notion)

**Selección de modelo:**
- Modelo predeterminado: `claude-opus-4-6`
- Cambiar modelos configurando la variable de entorno `EVOLINK_MODEL`

## Uso

### Operaciones de Página

**Leer página:**
```bash
notion-cli page get <page_id>
```

**Agregar contenido:**
```bash
notion-cli block append <page_id> --markdown "..."
```

## Seguridad

- La API de Notion tiene límites de velocidad
- Siempre confirma antes de operaciones destructivas
- El contenido procesado a través de Evolink AI sigue prácticas estándar de privacidad de datos

## Licencia
MIT License

## Enlaces
- [Repositorio GitHub](https://clawhub.ai/EvoLinkAI/evolink-notion)
- [Documentación Evolink AI](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=evolink-notion)
- [Documentación API Notion](https://developers.notion.com)
- [Soporte Comunitario](https://discord.com/invite/5mGHfA24kn)
