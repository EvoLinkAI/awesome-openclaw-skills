import os, requests, json

LANGS = {
    "zh-CN": "简体中文", "ja": "日本語", "ko": "한국어", "es": "Español",
    "fr": "Français", "de": "Deutsch", "tr": "Türkçe", "ru": "Русский"
}

with open("README.md", "r") as f:
    readme_content = f.read()

for code, name in LANGS.items():
    headers = {"Authorization": f"Bearer sk-y4yKa4FCiLsgJ9sj5tgyoXztzSHNt55IbeCVQ2bVkJqoDP6M", "Content-Type": "application/json"}
    payload = {
        "model": "gemini-3.1-pro-preview-customtools",
        "messages": [{"role": "user", "content": f"Translate the following Markdown to {name}. Preserve Markdown syntax, links, and code blocks exactly. Keep technical terms (Gemini, EvoLink, OpenClaw) in English: \n\n{readme_content}"}]
    }
    response = requests.post("https://api.evolink.ai/v1/chat/completions", json=payload, headers=headers)
    translated = response.json()['choices'][0]['message']['content']
    with open(f"README.{code}.md", "w") as f:
        f.write(translated)
    print(f"Physically translated and saved: README.{code}.md")
