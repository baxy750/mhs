import re

def define_env(env):
    @env.filter
    def morph(text):
        parts = text.split('|')
        html = parts[0]
        for part in parts[1:]:
            raw = part.replace('‑', '')
            html += f'<span class="morph-hide">{raw}</span><span class="morph-show">{part}</span>'
        return f'<span class="morph">{html}</span>'

    @env.macro
    def expand(text):
        return re.sub(r'\[\[(.*?)\]\]', lambda m: morph(m.group(1)), text)
