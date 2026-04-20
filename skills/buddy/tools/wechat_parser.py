#!/usr/bin/env python3
"""微信聊天记录解析器

支持主流导出工具的格式：
- WeChatMsg 导出（txt/html/csv）
- 留痕导出（json）
- PyWxDump 导出（sqlite）
- 手动复制粘贴（纯文本）

Usage:
    python3 wechat_parser.py --file <path> --target <name> --output <output_path> [--format auto]
"""

import argparse
import json
import re
import os
import sys
from datetime import datetime
from typing import Optional
from pathlib import Path


def detect_format(file_path: str) -> str:
    """自动检测文件格式"""
    ext = Path(file_path).suffix.lower()

    if ext == '.json':
        return 'liuhen'
    elif ext == '.csv':
        return 'wechatmsg_csv'
    elif ext in ('.html', '.htm'):
        return 'wechatmsg_html'
    elif ext in ('.db', '.sqlite'):
        return 'pywxdump'
    elif ext == '.txt':
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            first_lines = f.read(2000)
        if re.search(r'\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}', first_lines):
            return 'wechatmsg_txt'
        return 'plaintext'
    else:
        return 'plaintext'


def parse_wechatmsg_txt(file_path: str, target_name: str) -> dict:
    """解析 WeChatMsg 导出的 txt 格式"""
    messages = []
    current_msg = None
    msg_pattern = re.compile(r'^(\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2})\s+(.+)$')

    with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            line = line.rstrip('\n')
            match = msg_pattern.match(line)
            if match:
                if current_msg:
                    messages.append(current_msg)
                timestamp, sender = match.groups()
                current_msg = {
                    'timestamp': timestamp,
                    'sender': sender.strip(),
                    'content': ''
                }
            elif current_msg and line.strip():
                if current_msg['content']:
                    current_msg['content'] += '\n'
                current_msg['content'] += line

    if current_msg:
        messages.append(current_msg)

    target_msgs = [m for m in messages if target_name in m.get('sender', '')]
    all_target_text = ' '.join([m['content'] for m in target_msgs if m.get('content')])

    analysis = analyze_text(all_target_text, target_msgs)

    return {
        'target_name': target_name,
        'total_messages': len(messages),
        'target_messages': len(target_msgs),
        'sample_messages': [m['content'] for m in target_msgs[:50] if m.get('content')],
        'analysis': analysis,
    }


def parse_liuhen_json(file_path: str, target_name: str) -> dict:
    """解析留痕导出的 json 格式"""
    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)

    messages = data if isinstance(data, list) else data.get('messages', [])
    target_msgs = [m for m in messages
                   if target_name in str(m.get('sender', '')) or
                   target_name in str(m.get('nickname', ''))]

    all_text = ' '.join([str(m.get('content', '')) for m in target_msgs])
    analysis = analyze_text(all_text, target_msgs)

    return {
        'target_name': target_name,
        'total_messages': len(messages),
        'target_messages': len(target_msgs),
        'sample_messages': [str(m.get('content', '')) for m in target_msgs[:50]],
        'analysis': analysis,
    }


def parse_plaintext(file_path: str, target_name: str) -> dict:
    """解析纯文本粘贴"""
    with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()

    return {
        'target_name': target_name,
        'format': 'plaintext',
        'raw_text': content[:20000],
        'note': '纯文本格式，需要 AI 进一步分析'
    }


def analyze_text(text: str, messages: list) -> dict:
    """分析文本特征"""
    particles = ['哈哈', 'hh', '嗯', '哦', '噢', '嘿', '唉', '呜呜',
                 '啊', '呀', '吧', '呢', '嘛', '哎', '诶', '6', '绝了', '无语']
    particle_counts = {}
    for p in particles:
        count = text.lower().count(p)
        if count > 0:
            particle_counts[p] = count

    top_particles = sorted(particle_counts.items(), key=lambda x: -x[1])[:10]

    import re as _re
    emojis = _re.findall(r'[\U0001f600-\U0001f64f\U0001f300-\U0001f5ff\U0001f680-\U0001f6ff\U0001f900-\U0001f9ff]', text)
    emoji_counts = {}
    for e in emojis:
        emoji_counts[e] = emoji_counts.get(e, 0) + 1
    top_emojis = sorted(emoji_counts.items(), key=lambda x: -x[1])[:10]

    punct_habits = {
        '省略号(...)': text.count('...') + text.count('…'),
        '感叹号(!)': text.count('!') + text.count('！'),
        '问号(?)': text.count('?') + text.count('？'),
        '波浪号(~)': text.count('~') + text.count('～'),
    }

    msg_lengths = [len(str(m.get('content', ''))) for m in messages if m.get('content')]
    avg_len = sum(msg_lengths) / len(msg_lengths) if msg_lengths else 0

    return {
        'top_particles': top_particles,
        'top_emojis': top_emojis,
        'punctuation_habits': punct_habits,
        'avg_message_length': round(avg_len, 1),
        'message_style': 'short_burst' if avg_len < 20 else 'long_form',
    }


def main():
    parser = argparse.ArgumentParser(description='微信聊天记录解析器')
    parser.add_argument('--file', required=True, help='输入文件路径')
    parser.add_argument('--target', required=True, help='搭子的名字/昵称')
    parser.add_argument('--output', required=True, help='输出文件路径')
    parser.add_argument('--format', default='auto', help='文件格式（auto/wechatmsg_txt/liuhen/plaintext）')

    args = parser.parse_args()

    if not os.path.exists(args.file):
        print(f"错误：文件不存在 {args.file}", file=sys.stderr)
        sys.exit(1)

    fmt = args.format if args.format != 'auto' else detect_format(args.file)

    if fmt == 'wechatmsg_txt':
        result = parse_wechatmsg_txt(args.file, args.target)
    elif fmt == 'liuhen':
        result = parse_liuhen_json(args.file, args.target)
    else:
        result = parse_plaintext(args.file, args.target)

    os.makedirs(os.path.dirname(args.output) or '.', exist_ok=True)
    with open(args.output, 'w', encoding='utf-8') as f:
        f.write(f"# 微信聊天记录分析 — {args.target}\n\n")
        f.write(f"来源文件：{args.file}\n")
        f.write(f"检测格式：{fmt}\n")
        f.write(f"总消息数：{result.get('total_messages', 'N/A')}\n")
        f.write(f"ta的消息数：{result.get('target_messages', 'N/A')}\n\n")

        analysis = result.get('analysis', {})

        if analysis.get('top_particles'):
            f.write("## 高频语气词\n")
            for word, count in analysis['top_particles']:
                f.write(f"- {word}: {count}次\n")
            f.write("\n")

        if analysis.get('top_emojis'):
            f.write("## 高频 Emoji\n")
            for emoji, count in analysis['top_emojis']:
                f.write(f"- {emoji}: {count}次\n")
            f.write("\n")

        if analysis.get('punctuation_habits'):
            f.write("## 标点习惯\n")
            for punct, count in analysis['punctuation_habits'].items():
                f.write(f"- {punct}: {count}次\n")
            f.write("\n")

        f.write(f"## 消息风格\n")
        f.write(f"- 平均消息长度：{analysis.get('avg_message_length', 'N/A')} 字\n")
        f.write(f"- 风格：{'短句连发型' if analysis.get('message_style') == 'short_burst' else '长段落型'}\n\n")

        if result.get('sample_messages'):
            f.write("## 消息样本（前50条）\n")
            for i, msg in enumerate(result['sample_messages'], 1):
                f.write(f"{i}. {msg}\n")

    print(f"分析完成，结果已写入 {args.output}")


if __name__ == '__main__':
    main()
