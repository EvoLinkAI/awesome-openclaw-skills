🌐 [English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Türkçe](README.tr.md) | [中文](README.zh.md)

# डेटा विश्लेषण सहायक

**EvoLink API का उपयोग करके AI-संचालित डेटा विश्लेषण**

[Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) द्वारा संचालित

निर्णय-प्रथम पद्धति और सांख्यिकीय कठोरता के साथ CSV, Excel और JSON फ़ाइलों का विश्लेषण करें।

## 🚀 त्वरित शुरुआत

```bash
bash scripts/analyze.sh sales_data.csv "What are the top revenue drivers?"
```

## 🔑 कॉन्फ़िगरेशन

अपनी API कुंजी सेट करें:

```bash
export EVOLINK_API_KEY="your-key"
```

👉 [मुफ्त API कुंजी प्राप्त करें](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)

## 📖 उपयोग

### बुनियादी विश्लेषण

```bash
bash scripts/analyze.sh <file_path> "<analysis_question>"
```

**समर्थित प्रारूप:**
- CSV (`.csv`)
- Excel (`.xlsx`, `.xls`)
- JSON (`.json`)

### उदाहरण प्रश्न

```bash
# रुझान विश्लेषण
bash scripts/analyze.sh sales.csv "What's the monthly revenue trend?"

# तुलना
bash scripts/analyze.sh experiment.csv "Is variant A significantly better than B?"

# विभाजन
bash scripts/analyze.sh users.csv "Which user segments have highest retention?"

# विसंगति पहचान
bash scripts/analyze.sh metrics.csv "Are there any unusual patterns in the last 30 days?"
```

## ⚙️ कॉन्फ़िगरेशन

| वेरिएबल | डिफ़ॉल्ट | आवश्यक | विवरण |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | हाँ | आपकी Evolink API कुंजी। [मुफ्त में प्राप्त करें →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) |
| `EVOLINK_MODEL` | `[REDACTED]` | नहीं | विश्लेषण के लिए मॉडल। [Evolink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) द्वारा समर्थित किसी भी मॉडल पर स्विच करें |
| `DATA_ANALYSIS_SAFE_DIR` | `$HOME/.openclaw/workspace` | नहीं | स्थानीय फ़ाइल एक्सेस के लिए अनुमत निर्देशिका |

आवश्यक बाइनरी: `curl`, `jq`, `python3`, `file`.

## 🎯 मूल सिद्धांत

**निर्णय के बिना विश्लेषण केवल अंकगणित है।**

यह कौशल इन पर जोर देता है:
- निर्णय-प्रथम पद्धति
- सांख्यिकीय कठोरता (नमूना आकार, विश्वास अंतराल, प्रभाव आकार)
- स्पष्ट आउटपुट मानक (अंतर्दृष्टि-प्रथम, मात्रात्मक अनिश्चितता)
- स्पष्ट सीमाएं और चेतावनियां

## 📊 यह क्या करता है

1. **आपकी डेटा फ़ाइल पढ़ता है** (CSV/Excel/JSON)
2. **EvoLink API को भेजता है** आपके विश्लेषण प्रश्न के साथ
3. **संरचित अंतर्दृष्टि लौटाता है** जिसमें शामिल हैं:
   - मुख्य निष्कर्ष
   - सांख्यिकीय विश्वास
   - चेतावनियां और सीमाएं
   - अनुशंसित अगले कदम

## 🔒 सुरक्षा

**क्रेडेंशियल और नेटवर्क**

EvoLink API को कॉल करने के लिए `EVOLINK_API_KEY` की आवश्यकता है। आपकी डेटा फ़ाइल सामग्री और विश्लेषण प्रश्न प्रसंस्करण के लिए `api.evolink.ai` को भेजे जाते हैं। EvoLink डेटा को प्रोसेस करता है और विश्लेषण परिणाम लौटाता है। प्रसंस्करण के बाद कोई डेटा संग्रहीत नहीं किया जाता है।

**फ़ाइल एक्सेस**

आपके स्थानीय फ़ाइल सिस्टम से निर्दिष्ट डेटा फ़ाइल पढ़ता है। फ़ाइलें `DATA_ANALYSIS_SAFE_DIR` (डिफ़ॉल्ट: `$HOME/.openclaw/workspace`) के भीतर होनी चाहिए। स्क्रिप्ट फ़ाइल पथों को मान्य करती है और सुरक्षा के लिए सिमलिंक को अस्वीकार करती है।

फ़ाइल पथ `realpath -e` के माध्यम से हल किए जाते हैं (फ़ाइल का अस्तित्व आवश्यक है, सभी सिमलिंक हल करता है)। सिमलिंक इनपुट स्पष्ट रूप से अस्वीकार किए जाते हैं।

संवेदनशील फ़ाइलें नाम से ब्लैकलिस्ट की गई हैं: `.env*`, `*.key`, `*.pem`, `*.p12`, `*.pfx`, `id_rsa*`, `authorized_keys`, `config.json`, `.bash_history`, `.ssh`, `shadow`, `passwd`.

**फ़ाइल आकार सीमा**: डेटा फ़ाइलों के लिए अधिकतम 50MB।

**MIME सत्यापन**: केवल `text/csv`, `text/plain`, `application/json`, `application/vnd.ms-excel`, `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet` स्वीकार किए जाते हैं।

**नेटवर्क एक्सेस**

- **EvoLink API** (`api.evolink.ai`) - डेटा भेजता है और विश्लेषण प्राप्त करता है

सभी नेटवर्क कॉल curl का उपयोग करती हैं और स्क्रिप्ट स्रोत में ऑडिट की जा सकती हैं।

**स्थायित्व और विशेषाधिकार**

यह कौशल अन्य कौशल या सिस्टम सेटिंग्स को संशोधित नहीं करता है। उन्नत या स्थायी अनुमतियों का अनुरोध नहीं करता है।

## 📄 लाइसेंस

MIT

## 🔗 लिंक

- [API संदर्भ](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)
- [समुदाय](https://discord.com/invite/5mGHfA24kn)
- [सहायता](mailto:support@evolink.ai)
- [API कुंजी प्राप्त करें](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) — मुफ्त साइनअप

[Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) द्वारा संचालित
