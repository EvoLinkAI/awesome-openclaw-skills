import os, sys, requests, json

LANGS = {
    "zh-CN": "简体中文", "ja": "日本語", "ko": "한국어", "es": "Español",
    "fr": "Français", "de": "Deutsch", "tr": "Türkçe", "ru": "Русский"
}

# 简易翻译逻辑：读取主 README，调用 API 翻译
with open("README.md", "r") as f:
    readme_content = f.read()

for code, name in LANGS.items():
    # 物理检查翻译文件是否存在
    filename = f"README.{code}.md"
    if not os.path.exists(filename):
        continue

    # 调用 EvoLink API 进行高质量翻译
    headers = {"Authorization": f"Bearer {os.getenv('EVOLINK_API_KEY')}", "Content-Type": "application/json"}
    payload = {
        "model": "gemini-3.1-pro-preview-customtools",
        "messages": [{
            "role": "user",
            "content": f"Translate the following Markdown content to {name}. Keep all Markdown syntax, links, and code blocks unchanged. Retain technical terms (EvoLink, OpenClaw, Gemini) in English: \n\n{readme_content}"
        }]
    }
    response = requests.post("https://api.evolink.ai/v1/chat/completions", json=payload, headers=headers)
    translated = response.json()['choices'][0]['message']['content']
    
    with open(filename, "w") as f:
        f.write(translated)
    print(f"Translated {filename}")
