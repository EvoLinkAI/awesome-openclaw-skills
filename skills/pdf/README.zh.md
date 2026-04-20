🌐 [English](README.md) | [简体中文](README.zh.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Español](README.es.md) | [Русский](README.ru.md)

# PDF 工具包

**Comprehensive PDF manipulation toolkit for extracting text and tables, creating new PDFs, merging/splitting documents, and handling forms.**

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=pdf-toolkit)

A comprehensive instruction-only skill that provides Claude with complete guidance for PDF processing operations using Python libraries and command-line tools.

## 🚀 🚀 快速开始

本技能仅提供指令。安装后，Claude 可协助你进行任何 PDF 操作：

```bash
# Install the skill
clawhub install pdf-toolkit

# Then ask Claude:
# "Extract all tables from report.pdf to Excel"
# "Merge these 3 PDFs into one"
# "Create a PDF with this text and a table"
```

## 📖 📖 使用方法

### 提取 PDF 文本

```python
from pypdf import PdfReader

reader = PdfReader("document.pdf")
text = ""
for page in reader.pages:
    text += page.extract_text()
print(text)
```

### Merge Multiple PDFs

```python
from pypdf import PdfWriter, PdfReader

writer = PdfWriter()
for pdf_file in ["doc1.pdf", "doc2.pdf", "doc3.pdf"]:
    reader = PdfReader(pdf_file)
    for page in reader.pages:
        writer.add_page(page)

with open("merged.pdf", "wb") as output:
    writer.write(output)
```

### Extract Tables to Excel

```python
import pdfplumber
import pandas as pd

with pdfplumber.open("document.pdf") as pdf:
    all_tables = []
    for page in pdf.pages:
        tables = page.extract_tables()
        for table in tables:
            if table:
                df = pd.DataFrame(table[1:], columns=table[0])
                all_tables.append(df)
    
    if all_tables:
        combined_df = pd.concat(all_tables, ignore_index=True)
        combined_df.to_excel("output.xlsx", index=False)
```

### Create New PDF

```python
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas

c = canvas.Canvas("output.pdf", pagesize=letter)
c.drawString(100, 750, "Hello World!")
c.save()
```

## 🔑 Configuration

### EvoLink API (Optional)

For AI-powered PDF analysis and processing, set your EvoLink API key:

```bash
export EVOLINK_API_KEY="your-key-here"
```

Default model: `claude-opus-4-6` (no configuration needed).

To use a different model:

```bash
export EVOLINK_MODEL="claude-sonnet-4-5-20250929"
```

For other available models, see the [documentation](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=pdf-toolkit).

👉 [Get free API key](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=pdf-toolkit)

### Python 库

This skill provides instructions for using standard Python PDF libraries:
- **pypdf** - Basic operations (merge, split, rotate, encrypt)
- **pdfplumber** - Text and table extraction
- **reportlab** - Create PDFs from scratch
- **pytesseract + pdf2image** - OCR for scanned PDFs

Install via pip:
```bash
pip install pypdf pdfplumber reportlab pytesseract pdf2image
```

## 🛠️ Supported Operations

- **Extract**: Text, tables, images, metadata
- **Merge**: Combine multiple PDFs
- **Split**: Separate pages or page ranges
- **Create**: Generate PDFs from scratch
- **Modify**: Rotate, watermark, encrypt
- **Forms**: Fill out PDF forms
- **OCR**: Extract text from scanned PDFs

## 📚 Python Libraries Covered

- **pypdf**: Basic operations (merge, split, rotate, encrypt)
- **pdfplumber**: Text and table extraction with layout preservation
- **reportlab**: Create PDFs from scratch
- **pytesseract + pdf2image**: OCR for scanned PDFs

## 🔧 Command-Line Tools

- **pdftotext** (poppler-utils): Extract text
- **qpdf**: Merge, split, rotate, decrypt
- **pdftk**: Alternative PDF manipulation tool

## 🔒 Security

**Credentials & Network**

This skill does not require API keys or make network requests. All operations are performed locally using Python libraries.

**File Access**

This skill provides instructions for reading and writing PDF files. Claude will only access files you explicitly specify.

**Network Access**

This skill does not make network requests.

**Persistence & Privilege**

This skill does not modify other skills or system settings. It only provides instructions for PDF manipulation.

## 📄 License

MIT

## 🔗 链接

- [ClawHub](https://github.com/EvoLinkAI/pdf-skill-for-openclaw)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=pdf-toolkit)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
