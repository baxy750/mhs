import markdown

def define_env(env):

    # Expandable content section (Markdown supported)
    @env.macro
    def expand(title, content):
        html = markdown.markdown(content)
        return f"""
<details>
<summary>{title}</summary>

{html}

</details>
"""

    # Alias macro: note = expand
    @env.macro
    def note(title, content):
        return expand(title, content)

    # Morphology toggle (for use with [[word|‑ending]])
    @env.macro
    def morph(base, *suffixes):
        parts = ''.join(
            f'<span class="morph-hide">{s.strip("-")}</span><span class="morph-show">‑{s.strip("-")}</span>'
            for s in suffixes
        )
        return f'<span class="morph morph-toggle">{base}{parts}</span>'

    # Simple HTML <details> wrapper (raw HTML only)
    @env.macro
    def details(summary, content):
        return f'<details><summary>{summary}</summary>{content}</details>'


# Macros usage guide (for content authors):

# Expandable sections (Markdown inside is supported):
#   {{ expand("More", "Én itt vagyok, **te ott vagy**.") }}
#   {{ note("Example", "- Én itt vagyok\n- Te ott vagy") }}
# note is shorthand for expand, they both support markdown

# Morphological (morph) word breakdown (toggle-style display in markdown text):
#   [[Magyar|‑ország|‑ban]]
# Renders as: Magyarországban (toggle shows: Magyar‑ország‑ban)
# Only use the [[...|...|...]] form inside Markdown — do not wrap in {{ }}

# Expandable details section - RAW HTML {{ details("See more", "<ul><li>Raw HTML only</li></ul>") }}
