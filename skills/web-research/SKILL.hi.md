---
name: web-research
description: EvoLink API के माध्यम से वेब खोज। शीर्षक, URL और विवरण के साथ साफ, स्वरूपित परिणाम लौटाता है। Powered by evolink.ai
metadata: {"clawdbot":{"emoji":"🔍","requires":{"bins":["bash","curl","jq"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# Web Search Assistant

EvoLink API का उपयोग करके वेब खोज। शीर्षक, URL और विवरण के साथ साफ, स्वरूपित परिणाम लौटाता है।

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## कब उपयोग करें

जब उपयोगकर्ता निम्नलिखित का अनुरोध करें तो इस स्किल का उपयोग करें:
- जानकारी या संसाधनों के लिए वेब खोज
- वर्तमान या हाल की जानकारी ऑनलाइन खोजना
- वर्तमान वेब डेटा की आवश्यकता वाला शोध
- वेब स्रोतों का उपयोग करके तथ्य-जांच या सत्यापन
- किसी विषय पर URL और संसाधन एकत्र करना

## खोज

```bash
{baseDir}/scripts/search.sh "क्वेरी"
{baseDir}/scripts/search.sh "क्वेरी" 20
```

## विकल्प

- `<query>`: खोज क्वेरी
- `<max_results>`: परिणामों की संख्या (डिफ़ॉल्ट: 10)

## कॉन्फ़िगरेशन

अपनी EvoLink API कुंजी सेट करें:

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [मुफ्त API कुंजी प्राप्त करें](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## उदाहरण

```bash
bash scripts/search.sh "Claude Opus 4 features"
```

आउटपुट:
```
🔍 खोज रहे हैं: Claude Opus 4 features

📄 Claude Opus 4: New Features and Capabilities
🔗 https://example.com/opus-4
📝 Comprehensive guide to Claude Opus 4's new features...

📄 What's New in Claude Opus 4
🔗 https://example.com/whats-new
📝 Latest updates and improvements in Claude Opus 4...
```

## सुरक्षा

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

## लिंक

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [API संदर्भ](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)
- [समुदाय](https://discord.com/invite/5mGHfA24kn)
- [सहायता](mailto:support@evolink.ai)
