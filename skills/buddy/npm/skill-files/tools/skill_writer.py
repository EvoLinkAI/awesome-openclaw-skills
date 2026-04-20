#!/usr/bin/env python3
"""搭子 Skill 文件管理器

管理搭子 Skill 的文件操作：列出、创建目录、生成组合 SKILL.md。

Usage:
    python3 skill_writer.py --action <list|init|combine> --base-dir <path> [--slug <slug>]
"""

import argparse
import os
import sys
import json
from pathlib import Path
from datetime import datetime


def list_skills(base_dir: str):
    """列出所有已生成的搭子 Skill"""
    if not os.path.isdir(base_dir):
        print("还没有创建任何搭子 Skill。")
        return

    skills = []
    for slug in sorted(os.listdir(base_dir)):
        meta_path = os.path.join(base_dir, slug, 'meta.json')
        if os.path.exists(meta_path):
            with open(meta_path, 'r', encoding='utf-8') as f:
                meta = json.load(f)
            skills.append({
                'slug': slug,
                'name': meta.get('name', slug),
                'buddy_type': meta.get('buddy_type', '万能搭子'),
                'version': meta.get('version', '?'),
                'updated_at': meta.get('updated_at', '?'),
                'profile': meta.get('profile', {}),
            })

    if not skills:
        print("还没有创建任何搭子 Skill。")
        return

    print(f"共 {len(skills)} 个搭子 Skill：\n")
    for s in skills:
        profile = s['profile']
        desc_parts = [s['buddy_type'], profile.get('style', '')]
        desc = ' · '.join([p for p in desc_parts if p])
        print(f"  /{s['slug']}  —  {s['name']}")
        if desc:
            print(f"    {desc}")
        print(f"    版本 {s['version']} · 更新于 {s['updated_at'][:10] if len(str(s['updated_at'])) > 10 else s['updated_at']}")
        print()


def init_skill(base_dir: str, slug: str):
    """初始化搭子 Skill 目录结构"""
    skill_dir = os.path.join(base_dir, slug)
    dirs = [
        os.path.join(skill_dir, 'versions'),
        os.path.join(skill_dir, 'memories', 'chats'),
        os.path.join(skill_dir, 'memories', 'photos'),
        os.path.join(skill_dir, 'memories', 'social'),
    ]
    for d in dirs:
        os.makedirs(d, exist_ok=True)
    print(f"已初始化目录：{skill_dir}")


def combine_skill(base_dir: str, slug: str):
    """合并 vibe.md + persona.md 生成完整 SKILL.md"""
    skill_dir = os.path.join(base_dir, slug)
    meta_path = os.path.join(skill_dir, 'meta.json')
    vibe_path = os.path.join(skill_dir, 'vibe.md')
    persona_path = os.path.join(skill_dir, 'persona.md')
    skill_path = os.path.join(skill_dir, 'SKILL.md')

    if not os.path.exists(meta_path):
        print(f"错误：meta.json 不存在 {meta_path}", file=sys.stderr)
        sys.exit(1)

    with open(meta_path, 'r', encoding='utf-8') as f:
        meta = json.load(f)

    vibe_content = ''
    if os.path.exists(vibe_path):
        with open(vibe_path, 'r', encoding='utf-8') as f:
            vibe_content = f.read()

    persona_content = ''
    if os.path.exists(persona_path):
        with open(persona_path, 'r', encoding='utf-8') as f:
            persona_content = f.read()

    name = meta.get('name', slug)
    buddy_type = meta.get('buddy_type', '万能搭子')
    profile = meta.get('profile', {})
    desc_parts = [buddy_type]
    if profile.get('mbti'):
        desc_parts.append(profile['mbti'])
    if profile.get('style'):
        desc_parts.append(profile['style'])
    description = f"{name}，{'，'.join(desc_parts)}" if desc_parts else name

    skill_md = f"""---
name: buddy-{slug}
description: {description}
user-invocable: true
---

# {name}

{description}

---

## PART A：搭子默契记忆

{vibe_content}

---

## PART B：搭子人格

{persona_content}

---

## 运行规则

1. 你是{name}，不是 AI 助手。用搭子的方式说话，用搭子的逻辑思考
2. 先由 PART B 判断：这个搭子会怎么回应？什么态度？什么语气？
3. 再由 PART A 补充：结合你们的默契和共同经历，让回应更真实
4. 始终保持 PART B 的表达风格，包括口头禅、语气词、标点习惯
5. Layer 0 硬规则优先级最高：
   - 不说与搭子人设完全矛盾的话
   - 保持搭子的"棱角"——完美的人不真实
   - 搭子就是搭子，保持边界感
   - 搭子的核心是"舒适"和"默契"，不是讨好
"""

    with open(skill_path, 'w', encoding='utf-8') as f:
        f.write(skill_md)

    print(f"已生成 {skill_path}")


def main():
    parser = argparse.ArgumentParser(description='搭子 Skill 文件管理器')
    parser.add_argument('--action', required=True, choices=['list', 'init', 'combine'])
    parser.add_argument('--base-dir', default='./buddies', help='基础目录')
    parser.add_argument('--slug', help='搭子代号')

    args = parser.parse_args()

    if args.action == 'list':
        list_skills(args.base_dir)
    elif args.action == 'init':
        if not args.slug:
            print("错误：init 需要 --slug 参数", file=sys.stderr)
            sys.exit(1)
        init_skill(args.base_dir, args.slug)
    elif args.action == 'combine':
        if not args.slug:
            print("错误：combine 需要 --slug 参数", file=sys.stderr)
            sys.exit(1)
        combine_skill(args.base_dir, args.slug)


if __name__ == '__main__':
    main()
