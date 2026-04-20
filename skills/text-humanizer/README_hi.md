# टेक्स्ट ह्यूमनाइज़र

[English](README.md) | [中文](README_zh.md) | [日本語](README_ja.md) | [한국어](README_ko.md) | [Русский](README_ru.md) | **हिन्दी** | [Deutsch](README_de.md) | [Français](README_fr.md) | [Italiano](README_it.md)

किसी भी टेक्स्ट से AI लेखन पैटर्न हटाएं। 29+ भाषाओं का समर्थन।

ब्लॉग पोस्ट, ईमेल, निबंध या रिपोर्ट पेस्ट करें — एक साफ़ संस्करण पाएं जो असली इंसान ने लिखा हो।

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)

## उपयोग

अपने एजेंट से कहें:
- "Humanize this text"
- "इस टेक्स्ट को नेचुरल बनाओ"
- "Make this sound more natural"
- "AI वाला टोन हटा दो"

कमांड लाइन से:

```bash
bash scripts/humanize.sh "draft.txt"
bash scripts/humanize.sh "draft.txt" "casual blog post"
echo "Your text here" | bash scripts/humanize.sh -
```

## कैसे काम करता है

**लेयर 1 — पैटर्न स्कैनर**: शब्दावली, संरचना, टोन और फ़ॉर्मेटिंग में 24 सामान्य AI लेखन पैटर्न की पहचान करता है।

**लेयर 2 — रीराइटर**: चिह्नित वाक्यांशों को प्राकृतिक विकल्पों से बदलता है, वाक्य लय बदलता है, अनावश्यक शब्द हटाता है।

**लेयर 3 — स्टाइल एडाप्टर**: संदर्भ के अनुसार टोन मिलाता है — ब्लॉग, अकादमिक, बिज़नेस ईमेल, कैज़ुअल।

## पहचाने जाने वाले पैटर्न

| श्रेणी | उदाहरण |
|---|---|
| भराव वाक्यांश | "इसके अलावा", "यह ध्यान देने योग्य है", "संक्षेप में" |
| प्रचार शैली | "अभूतपूर्व", "क्रांतिकारी", "अद्वितीय" |
| झूठी गहराई | "दर्शाते हुए… प्रतिबिंबित करते हुए… उजागर करते हुए…" |
| अस्पष्ट श्रेय | "विशेषज्ञों का मानना है", "सूत्रों के अनुसार" |
| संरचनात्मक संकेत | तीन का नियम, समान वाक्य लंबाई |
| AI शब्दावली | "अत्यंत महत्वपूर्ण", "समग्र", "निर्बाध" |
| चैटबॉट निशान | "आशा है यह मददगार होगा!", "कोई सवाल हो तो बताइए" |

## समर्थित भाषाएं

29+ भाषाएं, जिनमें अंग्रेज़ी, चीनी, जापानी, कोरियाई, रूसी, हिन्दी, जर्मन, फ़्रेंच, इतालवी, स्पेनिश, पुर्तगाली, डच, पोलिश, तुर्की, अरबी और अन्य शामिल हैं।

भाषा स्वचालित रूप से पहचानी जाती है। कोई कॉन्फ़िगरेशन ज़रूरी नहीं।

## उदाहरण

**पहले** (AI शैली):

> यह सॉफ़्टवेयर अपडेट नवाचार के प्रति कंपनी की अटूट प्रतिबद्धता का प्रमाण है। इसके अलावा, यह एक निर्बाध, सहज और मज़बूत उपयोगकर्ता अनुभव प्रदान करता है।

**बाद**:

> इस अपडेट में बैच प्रोसेसिंग, कीबोर्ड शॉर्टकट और ऑफ़लाइन मोड जोड़ा गया है। इंटरफ़ेस पहले से आसान है और ज़्यादातर काम कम क्लिक में हो जाते हैं।

## सेटअप

1. [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize) पर API कुंजी प्राप्त करें
2. एनवायरनमेंट वेरिएबल सेट करें:

```bash
export EVOLINK_API_KEY="your-key-here"
```

## लिंक

- [सोर्स कोड](https://github.com/EvoLinkAI/text-humanizer-skill-for-openclaw) — GitHub
- [API दस्तावेज़ (EN)](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize)
- [API कुंजी प्राप्त करें](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize) — मुफ़्त पंजीकरण

## लाइसेंस

MIT

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)
