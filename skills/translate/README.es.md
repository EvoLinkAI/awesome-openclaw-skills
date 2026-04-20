# Translate — Skill de traducción de idiomas con IA (OpenClaw)

Translate text accurately — preserve formatting, handle plurals, and adapt tone per locale. Powered by [EvoLink](https://evolink.ai/?utm_source=github&utm_medium=skill&utm_campaign=translate).

🌐 [English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | Español

---

## What Is This?

Master accurate translation that preserves meaning, formatting, and cultural context. Translate text, files, and conversations between any languages.

[Install Now →](https://clawhub.ai/EvoLinkAI/evolink-translate)

---

## Formatting Preservation

- Never translate content inside code blocks, HTML tags, or markdown syntax
- Preserve placeholders like , , ,  exactly as-is
- Keep markdown structure intact: headers, links, bold/italic formatting
- Maintain JSON/XML structure and keys — translate only values where appropriate

## Content Rules

- Don't translate: proper nouns, brand names, technical terms, URLs, email addresses
- Don't translate: code snippets, CSS classes, API endpoints, file extensions
- Preserve numbers, dates, and IDs in their original format unless locale conversion needed
- Keep consistent terminology throughout — create a glossary for repeated terms

## Language-Specific Handling

- **Plurals**: Use correct plural forms per target language rules (not English patterns)
- **Gender**: Ensure noun-adjective agreement in gendered languages
- **Formality**: Choose appropriate register based on context
- **RTL languages**: Consider text direction for Arabic/Hebrew but keep LTR elements (URLs, numbers)

## Cultural Adaptation

- Adapt idioms and expressions rather than literal translation
- Convert units when culturally appropriate
- Adjust date formats to locale standards
- Use local currency symbols and number formatting

## Context Awareness

- Disambiguate based on context
- Maintain document tone: formal business vs casual blog vs technical manual
- Consider target audience: children's content vs academic paper vs marketing copy
- Preserve original intent and emotional nuance

## Quality Control

- Read full context before translating to understand meaning
- Check that translated text flows naturally in target language
- Verify all formatting elements remain functional after translation
- Ensure consistent voice and terminology across the entire document

---

## Quick Start



## Configuration

- : Required for API access.
- : Optional. Defaults to .

[Get your free API key here →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=translate)

---

## Links

- [ClawHub](https://clawhub.ai/EvoLinkAI/evolink-translate)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=translate)
- [Community](https://discord.com/invite/clawd)
- [Support](mailto:support@evolink.ai)

---

## License
MIT
