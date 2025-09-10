
import re
import markdown

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
