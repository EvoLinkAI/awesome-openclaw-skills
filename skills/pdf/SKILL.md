---
name: pdf-toolkit
description: Comprehensive PDF manipulation toolkit for extracting text and tables, creating new PDFs, merging/splitting documents, and handling forms. Powered by evolink.ai
---

# PDF Toolkit

Comprehensive PDF manipulation toolkit for extracting text and tables, creating new PDFs, merging/splitting documents, and handling forms.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=pdf-skill-for-openclaw)

## When to Use

Use this skill when you need to:
- Extract text or tables from PDF documents
- Merge multiple PDFs into one
- Split a PDF into separate pages
- Create new PDFs programmatically
- Fill out PDF forms
- Add watermarks or rotate pages
- Extract metadata or images from PDFs

## Usage

This is an instruction-only skill. Claude will use the Python libraries and command-line tools described below to perform PDF operations.

**⚠️ Prerequisites:**
Before performing any task, Claude should verify if the required Python libraries are installed. If missing, guide the user to run:
```bash
pip install pypdf pdfplumber reportlab pytesseract pdf2image
```

### Python Libraries

**pypdf** - Basic operations (merge, split, rotate, encrypt)
**pdfplumber** - Text and table extraction with layout preservation
**reportlab** - Create PDFs from scratch
**pytesseract + pdf2image** - OCR for scanned PDFs

### Command-Line Tools

**pdftotext** (poppler-utils) - Extract text
**qpdf** - Merge, split, rotate, decrypt
**pdftk** - Alternative PDF manipulation tool

## Configuration

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


For other available models, see the [documentation](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=pdf-skill-for-openclaw).
👉 [Get free API key](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=pdf-skill-for-openclaw)

### Python Libraries

This skill provides instructions for using standard Python PDF libraries. No additional configuration required for basic operations.

## Example

### Extract Text from PDF

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

### Extract Tables

```python
import pdfplumber

with pdfplumber.open("document.pdf") as pdf:
    for page in pdf.pages:
        tables = page.extract_tables()
        for table in tables:
            print(table)
```

### Create New PDF

```python
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas

c = canvas.Canvas("output.pdf", pagesize=letter)
c.drawString(100, 750, "Hello World!")
c.save()
```

## Common Operations

### Split PDF into Pages

```python
from pypdf import PdfReader, PdfWriter

reader = PdfReader("input.pdf")
for i, page in enumerate(reader.pages):
    writer = PdfWriter()
    writer.add_page(page)
    with open(f"page_{i+1}.pdf", "wb") as output:
        writer.write(output)
```

### Rotate Pages

```python
from pypdf import PdfReader, PdfWriter

reader = PdfReader("input.pdf")
writer = PdfWriter()

page = reader.pages[0]
page.rotate(90)  # Rotate 90 degrees clockwise
writer.add_page(page)

with open("rotated.pdf", "wb") as output:
    writer.write(output)
```

### Extract Metadata

```python
from pypdf import PdfReader

reader = PdfReader("document.pdf")
meta = reader.metadata
print(f"Title: {meta.title}")
print(f"Author: {meta.author}")
print(f"Subject: {meta.subject}")
```

### Add Password Protection

```python
from pypdf import PdfReader, PdfWriter

reader = PdfReader("input.pdf")
writer = PdfWriter()

for page in reader.pages:
    writer.add_page(page)

writer.encrypt("userpassword", "ownerpassword")

with open("encrypted.pdf", "wb") as output:
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

### OCR Scanned PDFs

```python
import pytesseract
from pdf2image import convert_from_path

images = convert_from_path('scanned.pdf')
text = ""
for i, image in enumerate(images):
    text += f"Page {i+1}:\n"
    text += pytesseract.image_to_string(image)
    text += "\n\n"
print(text)
```

### Command-Line Examples

```bash
# Extract text preserving layout
pdftotext -layout input.pdf output.txt

# Merge PDFs
qpdf --empty --pages file1.pdf file2.pdf -- merged.pdf

# Split specific pages
qpdf input.pdf --pages . 1-5 -- pages1-5.pdf

# Remove password
qpdf --password=mypassword --decrypt encrypted.pdf decrypted.pdf

# Extract images
pdfimages -j input.pdf output_prefix
```

## Quick Reference

| Task | Best Tool | Example |
|------|-----------|---------|
| Extract text | pdfplumber | `page.extract_text()` |
| Extract tables | pdfplumber | `page.extract_tables()` |
| Merge PDFs | pypdf | `writer.add_page(page)` |
| Split PDFs | pypdf | One page per file |
| Create PDFs | reportlab | Canvas or Platypus |
| OCR scanned PDFs | pytesseract | Convert to image first |
| Command line merge | qpdf | `qpdf --empty --pages ...` |
| Fill forms | pypdf | See form filling examples |

## Security

**Credentials & Network**

This skill does not require API keys or make network requests. All operations are performed locally using Python libraries.

**File Access**

This skill provides instructions for reading and writing PDF files. Claude will only access files you explicitly specify.

**Network Access**

This skill does not make network requests.

**Persistence & Privilege**

This skill does not modify other skills or system settings. It only provides instructions for PDF manipulation.

## Links

- [ClawHub](https://clawhub.ai/evolinkai/evolink-pdf)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=pdf-skill-for-openclaw)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
