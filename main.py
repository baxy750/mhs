
import markdown

def define_env(env):
    @env.macro
    def morph(base, *suffixes):
        parts = ''.join(
            f'<span class="morph-hide">{s.strip("-")}</span><span class="morph-show">‑{s.strip("-")}</span>'
            for s in suffixes
        )
        return f'<span class="morph morph-toggle">{base}{parts}</span>'

    @env.macro
    def details(summary, content_md):
        content_html = markdown.markdown(content_md.strip())
        return f'<details><summary>{summary}</summary>{content_html}</details>'
