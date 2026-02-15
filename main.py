import re
import markdown

import yaml
from pathlib import Path

def _morph_core(*parts):
    parts = [str(p) for p in parts if p is not None]
    if not parts:
        return ""
    full = "".join(parts)
    hyphenated = "-".join(parts)
    return f'<span data-hyphen="{hyphenated}" data-plain="{full}">{full}</span>'

_FENCE_RE = re.compile(r'^(?:`{3,}|~{3,})')

def _replace_morph_brackets(md_text: str) -> str:
    def repl(match):
        parts = match.group(1).strip().split()
        return _morph_core(*parts)

    out, fenced = [], False
    for line in md_text.splitlines():
        if _FENCE_RE.match(line):
            fenced = not fenced
            out.append(line)
            continue
        if not fenced:
            line = re.sub(r'\[\[([^\[\]]+?)\]\]', repl, line)
        out.append(line)
    return "\n".join(out)

def define_env(env):
    @env.macro
    def morph(*parts):
        return _morph_core(*parts)

    @env.macro
    def expand(title, content):
        html = markdown.markdown(content)
        return f"<details><summary>{title}</summary>\n\n{html}\n</details>"

    @env.macro
    def note(title, content):
        return expand(title, content)

    @env.macro
    def details(summary, content):
        return f'<details><summary>{summary}</summary>{content}</details>'   

    # no registration here; we'll use on_pre_page_macros below

    @env.macro
    def render_phrases(topic):
        """Render a phrase table from docs/data/phrases.yml"""
        data_path = Path("docs/data/phrases.yml")
        with open(data_path, "r", encoding="utf-8") as f:
            phrases = yaml.safe_load(f)

        rows = phrases.get(topic, [])

        # Run morph replacement on the header too
        header = _replace_morph_brackets("| [[Magyar ul]] | [[Angol ul]] | Jegyzet |")
        divider = "|---------------|--------------|---------|"

        out = [header, divider]

        for row in rows:
            hun   = _replace_morph_brackets(row.get("hun", ""))
            eng   = _replace_morph_brackets(row.get("eng", ""))
            notes = _replace_morph_brackets(row.get("notes", ""))
            out.append(f"| {hun} | {eng} | {notes} |")

        # Convert the generated markdown table to HTML and wrap it in a container
        table_md = "\n".join(out)
        table_html = markdown.markdown(table_md, extensions=["tables"]) if hasattr(markdown, 'markdown') else markdown(table_md)
        return f'<div class="phrases-wrapper">{table_html}</div>'

# Let mkdocs-macros call this before macros are rendered for each page
def on_pre_page_macros(env):
    # env.markdown is the page's markdown before macro rendering
    env.markdown = _replace_morph_brackets(env.markdown)




# Macros usage guide (for content authors):

# Expandable sections (Markdown inside is supported):
#   {{ expand("More", "Én itt vagyok, **te ott vagy**.") }}
#   {{ note("Example", "- Én itt vagyok\n- Te ott vagy") }}
# 'note' is shorthand for 'expand'

# Morphological (morph) word breakdown (toggle-style display):
#   [[Magyar ország ban]]
# Renders as: Magyarországban (toggle shows: Magyar‑ország‑ban)
# Only use the  [[... ... ...]] form inside Markdown
# In python use {{ morph("Magyar", "ország", "ban") }}

# Expandable raw HTML:
#   {{ details("See more", "<ul><li>Raw HTML only</li></ul>") }}
