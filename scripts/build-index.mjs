// Génère dist/index.html : la liste des talks construits, avec leur titre (frontmatter `title`).
import { readdirSync, readFileSync, existsSync, writeFileSync } from 'node:fs'

const talks = readdirSync('.', { withFileTypes: true })
  .filter((d) => d.isDirectory() && existsSync(`${d.name}/slides.md`) && existsSync(`dist/${d.name}/index.html`))
  .map((d) => {
    const src = readFileSync(`${d.name}/slides.md`, 'utf8')
    const title = src.match(/^title:\s*["']?(.+?)["']?\s*$/m)?.[1] ?? d.name
    return { slug: d.name, title }
  })

const esc = (s) => s.replace(/[&<>"]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' })[c])
const items = talks.map((t) => `<li><a href="./${t.slug}/">${esc(t.title)}</a></li>`).join('\n')

writeFileSync('dist/index.html', `<!doctype html>
<html lang="fr"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Talks · Arnaud Hatzenbuhler</title>
<style>body{font-family:system-ui,sans-serif;max-width:40rem;margin:4rem auto;padding:0 1rem;color:#1f1830;background:#f6f4fa}a{color:#5b1fb0}li{margin:.6rem 0}</style>
</head><body><h1>Talks</h1><ul>
${items}
</ul></body></html>
`)
console.log(`index : ${talks.length} talk(s)`)
