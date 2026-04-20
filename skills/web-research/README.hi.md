🌐 [English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [简体中文](README.zh-CN.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | हिन्दी | [Türkçe](README.tr.md)

# Web Search Assistant

**EvoLink API का उपयोग करके AI-संचालित वेब खोज**

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=web-search)

वेब खोजें और शीर्षक, URL और विवरण के साथ साफ, स्वरूपित परिणाम प्राप्त करें।

## 🚀 त्वरित शुरुआत

```bash
bash scripts/search.sh "AI coding assistants 2026"
bash scripts/search.sh "quantum computing breakthroughs" 20
```

## 🔑 कॉन्फ़िगरेशन

अपनी EvoLink API कुंजी सेट करें:

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [मुफ्त API कुंजी प्राप्त करें](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=web-search)

## 📖 उपयोग

### बुनियादी खोज

```bash
bash scripts/search.sh "खोज क्वेरी"
```

शीर्ष 10 परिणाम लौटाता है।

### परिणाम सीमित करें

```bash
bash scripts/search.sh "खोज क्वेरी" 20
```

परिणामों की अधिकतम संख्या निर्दिष्ट करें।

## 🔒 सुरक्षा

**क्रेडेंशियल और नेटवर्क**

EvoLink API को कॉल करने के लिए `EVOLINK_API_KEY` आवश्यक है। आपकी खोज क्वेरी प्रसंस्करण के लिए `api.evolink.ai` को भेजी जाती हैं। EvoLink आंतरिक रूप से वेब खोज को संभालता है और स्वरूपित परिणाम लौटाता है।

**फ़ाइल एक्सेस**

यह स्किल कोई फ़ाइल नहीं पढ़ता या लिखता है।

**नेटवर्क एक्सेस**

यह स्किल निम्नलिखित को नेटवर्क अनुरोध करता है:
- **EvoLink API** (`api.evolink.ai`) - वेब खोज करने के लिए

सभी नेटवर्क कॉल curl के माध्यम से की जाती हैं और स्क्रिप्ट स्रोत कोड में ऑडिट की जा सकती हैं।

**स्थिरता और विशेषाधिकार**

यह स्किल अन्य स्किल या सिस्टम सेटिंग्स को संशोधित नहीं करता है। कोई उन्नत या स्थायी विशेषाधिकार का अनुरोध नहीं किया जाता है।

## 📄 लाइसेंस

MIT

## 🔗 लिंक

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [API संदर्भ](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=web-search)
- [समुदाय](https://discord.com/invite/5mGHfA24kn)
- [सहायता](mailto:support@evolink.ai)
