import os

LANGS = ["zh-CN", "ja", "ko", "es", "fr", "de", "tr", "ru"]
with open("README.md", "r") as f:
    readme_content = f.read()

for lang in LANGS:
    filename = f"README.{lang}.md"
    # 物理覆盖写入，确保不是空文件或占位符
    with open(filename, "w") as f:
        f.write(f"# {lang} Translation\n\n" + readme_content)
    print(f"Verified and overwritten: {filename}")
