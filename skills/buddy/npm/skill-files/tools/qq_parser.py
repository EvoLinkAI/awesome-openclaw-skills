#!/usr/bin/env python3
"""QQ 聊天记录解析器

支持格式：
- QQ 消息管理器导出的 txt 格式
- QQ 消息管理器导出的 mht 格式

Usage:
    python3 qq_parser.py --file <path> --target <name> --output <output_path>
"""

import argparse
import re
import os
import sys
from pathlib import Path


def parse_qq_txt(file_path: str, target_name: str) -> dict:
    """解析 QQ 导出的 txt 格式"""
    messages = []
    current_msg = None
    msg_pattern = re.compile(r'^(\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2})\s+(.+?)(?:\((\d+)\))?\s*$')

    with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            line = line.rstrip('\n')
            match = msg_pattern.match(line)
            if match:
                if current_msg:
                    messages.append(current_msg)
                timestamp, sender, qq_number = match.groups()
                current_msg = {
                    'timestamp': timestamp,
                    'sender': sender.strip(),
                    'content': ''
                }
            elif current_msg and line.strip() and not line.startswith('==='):
                if current_msg['content']:
                    current_msg['content'] += '\n'
                current_msg['content'] += line

    if current_msg:
        messages.append(current_msg)

    target_msgs = [m for m in messages if target_name in m.get('sender', '')]

    return {
        'target_name': target_name,
        'total_messages': len(messages),
        'target_messages': len(target_msgs),
        'sample_messages': [m['content'] for m in target_msgs[:50] if m.get('content')],
    }


def parse_qq_mht(file_path: str, target_name: str) -> dict:
    """解析 QQ 导出的 mht 格式"""
    with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()

    clean_text = re.sub(r'<[^>]+>', '\n', content)
    clean_text = re.sub(r'\n{3,}', '\n\n', clean_text)

    return {
        'target_name': target_name,
        'format': 'mht',
        'raw_text': clean_text[:20000],
    }


def main():
    parser = argparse.ArgumentParser(description='QQ 聊天记录解析器')
    parser.add_argument('--file', required=True, help='输入文件路径')
    parser.add_argument('--target', required=True, help='搭子的名字/昵称')
    parser.add_argument('--output', required=True, help='输出文件路径')

    args = parser.parse_args()

    if not os.path.exists(args.file):
        print(f"错误：文件不存在 {args.file}", file=sys.stderr)
        sys.exit(1)

    ext = Path(args.file).suffix.lower()
    if ext in ('.mht', '.mhtml'):
        result = parse_qq_mht(args.file, args.target)
    else:
        result = parse_qq_txt(args.file, args.target)

    os.makedirs(os.path.dirname(args.output) or '.', exist_ok=True)
    with open(args.output, 'w', encoding='utf-8') as f:
        f.write(f"# QQ 聊天记录分析 — {args.target}\n\n")
        f.write(f"总消息数：{result.get('total_messages', 'N/A')}\n")
        f.write(f"ta的消息数：{result.get('target_messages', 'N/A')}\n\n")

        if result.get('sample_messages'):
            f.write("## 消息样本\n")
            for i, msg in enumerate(result['sample_messages'], 1):
                f.write(f"{i}. {msg}\n")
        elif result.get('raw_text'):
            f.write("## 原始文本（截取）\n\n")
            f.write(result['raw_text'][:10000])

    print(f"分析完成，结果已写入 {args.output}")


if __name__ == '__main__':
    main()
