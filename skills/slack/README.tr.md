# Slack Assistant — Claude Code için OpenClaw Skill'i

Akıllı yapay zeka özellikleriyle Slack API entegrasyonu — mesaj gönderme, kanal okuma, sohbet arama ve çalışma alanı yönetimi, Claude destekli özetleme ve taslak oluşturma ile. [evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack) tarafından geliştirilmiştir

[Bu Nedir?](#bu-nedir) | [Kurulum](#kurulum) | [Yapılandırma](#yapılandırma-kılavuzu) | [Kullanım](#kullanım) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack)

**Language / Dil:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Bu Nedir?

Claude Code'u Slack çalışma alanınıza bağlayan bir [OpenClaw](https://clawhub.ai) skill'i. Claude'a ne istediğinizi söylemeniz yeterli:

- "#general'a mesaj gönder"
- "#engineering'de neler oluyor?"
- "#product'taki son 50 mesajı özetle"
- "O konuya bir yanıt taslağı hazırla"

## Kurulum

### Seçenek 1: ClawHub (Önerilen)
```bash
npx clawhub install slack-assistant
```

### Seçenek 2: npm
```bash
npx evolinkai-slack-assistant
```

### Seçenek 3: Manuel
```bash
git clone https://github.com/EvoLinkAI/slack-skill-for-openclaw.git
cp -r slack-skill-for-openclaw /path/to/your/skills/slack-assistant/
```

## Yapılandırma Kılavuzu

### 1. Slack Uygulaması Oluşturun

1. [api.slack.com/apps](https://api.slack.com/apps) adresine gidin
2. **Create New App** > **From scratch** tıklayın
3. Uygulamanızı adlandırın ve çalışma alanınızı seçin
4. **OAuth & Permissions** > **Bot Token Scopes**'a gidin
5. Şu kapsamları ekleyin:
   - `channels:read`, `channels:write`, `channels:history`, `channels:manage`
   - `chat:write`
   - `files:read`, `files:write`
   - `groups:read`, `groups:write`, `groups:history`
   - `im:read`, `im:write`, `im:history`
   - `mpim:read`, `mpim:write`, `mpim:history`
   - `search:read`
   - `users:read`, `users:read.email`
   - `reactions:read`, `reactions:write`
6. **Install to Workspace** tıklayın ve yetkilendirin
7. **Bot User OAuth Token**'ı kopyalayın (`xoxb-` ile başlar)

### 2. Kimlik Bilgilerini Yapılandırın

```bash
mkdir -p ~/.slack-skill
echo '{"bot_token": "xoxb-your-token-here"}' > ~/.slack-skill/credentials.json
chmod 600 ~/.slack-skill/credentials.json
```

### 3. (İsteğe Bağlı) Yapay Zeka Özelliklerini Etkinleştirin

```bash
export EVOLINK_API_KEY="your-key-here"
```

[evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack) adresinden ücretsiz API anahtarı alın

## Kullanım

### Temel İşlemler

```bash
bash scripts/slack.sh channels
bash scripts/slack.sh list "#general" 20
bash scripts/slack.sh send "#general" "Merhaba ekip!"
bash scripts/slack.sh search "dağıtım"
bash scripts/slack.sh read CHANNEL_ID 1234567890.123456
bash scripts/slack.sh reply CHANNEL_ID 1234567890.123456 "Teşekkürler!"
```

### Yapay Zeka Özellikleri

```bash
bash scripts/slack.sh ai-summary "#engineering" 50
bash scripts/slack.sh ai-reply CHANNEL_ID 1234567890.123456
bash scripts/slack.sh ai-prioritize "#general" 30
```

### Kanal Yönetimi

```bash
bash scripts/slack.sh create-channel "new-project" --private
bash scripts/slack.sh invite "#new-project" "@alice"
bash scripts/slack.sh upload "#general" ./report.pdf
```

## Yapılandırma

| Değişken | Varsayılan | Açıklama |
|---|---|---|
| `SLACK_SKILL_DIR` | `~/.slack-skill` | Yapılandırma dizini |
| `EVOLINK_API_KEY` | — | Yapay zeka özellikleri için API anahtarı ([alın](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack)) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | Yapay zeka modeli ([belgeler](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)) |

## Bağlantılar

- [ClawHub](https://clawhub.ai/EvoLinkAI/slack-assistant)
- [Slack API Referansı](https://api.slack.com/methods)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)
- [Topluluk](https://discord.com/invite/5mGHfA24kn)
- [Destek](mailto:support@evolink.ai)

## Lisans

MIT
