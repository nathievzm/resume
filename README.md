# 🎀 resume 🎀

<div align="center">
  <img src="https://img.shields.io/badge/LuaLaTeX-FFE0EC?style=for-the-badge&logo=latex&logoColor=2D2640" alt="LuaLaTeX" />
  <img src="https://img.shields.io/badge/LaTeX3_(expl3)-FFE0EC?style=for-the-badge&logoColor=2D2640" alt="LaTeX3" />
  <img src="https://img.shields.io/badge/TikZ_·_Solar_Icons-FFE0EC?style=for-the-badge&logoColor=2D2640" alt="TikZ Solar Icons" />
  <img src="https://img.shields.io/badge/ATS--Friendly-FFE0EC?style=for-the-badge&logoColor=2D2640" alt="ATS-Friendly" />
</div>

<br />

> [!IMPORTANT]
> this résumé is magically built with **modern LuaLaTeX + LaTeX3 (`expl3`)** and structured like a real frontend **Design System** (`tokens` → `components` → `sections`). make sure you have a TeX distribution with `lualatex` (e.g. TinyTeX or TeX Live) installed if you'd like to compile it locally!

✨ my ATS-proof, single-column Software Engineering résumé — crafted with clean typography, modular LaTeX3 tokens, and pure vector icons so both recruiters and parsers love it equally.

## ✨ highlights

- **Design System Architecture:** Clean separation of concerns across `styles/` (tokens), `components/` (reusable UI macros), and `sections/` (pure content).
- **100% ATS-Safe Typography:** Single-column reading order, `Ligatures=TeX` (prevents `fi`/`fl` glyph traps), zero mid-word hyphenation (`\hyphenpenalty=10000`), and bundled local weights for **Sora**, **Inter**, and **GitHub Monaspace Neon**.
- **Pure Vector Solar Icons:** Official 24×24 **Solar Bold Duotone** SVG paths rendered via TikZ `svg.path` — zero Private-Use-Area (PUA) font glyphs leaking replacement characters into `pdftotext` or ATS parsers.
- **Typed LaTeX3 Configuration:** Switch paper size, layout, icons, timeline, and monospace dates from a single `\ResumeSetup` block powered by `l3keys`.
- **Privacy-First Contact Override:** Keeps personal email/phone in a gitignored `src/contact.local.tex`, automatically falling back to `src/contact.example.tex` for clean public clones.
- **Zero-Clutter VS Code Build & Orphan Guard:** Pre-configured 2-pass **LaTeX Workshop** recipe with `autoClean` keeps `src/` clean, while a custom `expl3` `\CVNeedSpace` guard keeps headings and role titles together across page breaks.

## 🎨 design system & architecture

| Token | Hex | Role |
| :--- | :--- | :--- |
| `PaperBg` (`GhostWhite`) | `#FCFBFE` | Soft warm-white page canvas |
| `InkHeading` (`MidnightViolet`) | `#2D2640` | Hero name, bold emphasis & titles |
| `InkPrimary` (`VintageGrape`) | `#4A4260` | Body prose & bullet copy |
| `BrandPrimary` (`StrawberryInk`) | `#B34A74` | Section headers & primary icon layer |
| `BrandDeep` (`StrawberryDeep`) | `#8F2F56` | High-contrast role titles, links & hero badge text |
| `BrandSoft` (`StrawberryCloud`) | `#FFE0EC` | Pastel hero title pill fill |
| `BrandRule` (`StrawberryRule`) | `#F5BDD4` | Dual-weight section rules & secondary duotone layer |

```text
resume/
├── .vscode/settings.json      # Pre-configured LuaLaTeX 2-pass recipe & LTeX+ spellcheck
├── fonts/                     # Bundled Sora, Inter & Monaspace Neon (used weights only)
├── src/
│   ├── resume.tex             # Main entry point & \ResumeSetup configuration
│   ├── contact.example.tex    # Public contact placeholder template
│   ├── contact.local.tex      # Gitignored private email/phone override
│   ├── styles/                # Design tokens (config, colors, spacing, fonts, typography, layout)
│   ├── components/            # Reusable LaTeX3 components & Solar Bold Duotone vector icons
│   └── sections/              # Pure content modules (01-summary → 05-education)
└── CONTRIBUTING.md            # Personal-repo override notice
```

## ⚙️ configuration

Toggle any layout or visual token from the single `\ResumeSetup` block in `src/resume.tex`:

| Option | Values | Default | Description |
| :--- | :--- | :--- | :--- |
| `paper` | `letter` \| `a4` | `letter` | Page geometry (US/Americas vs. Europe) |
| `heading` | `sora` \| `inter` | `sora` | Display heading font family |
| `layout` | `linear` \| `bento` \| `classic` | `linear` | Header & editorial layout variant |
| `datepills` | `true` \| `false` | `false` | Soft lilac pill badges behind primary dates |
| `companybar` | `true` \| `false` | `true` | Vertical accent bar on company headers |
| `icons` | `true` \| `false` | `true` | Pure TikZ Solar Bold Duotone vector icons |
| `timeline` | `true` \| `false` | `true` | Grouped vertical timeline for multi-role companies |
| `mono` | `true` \| `false` | `true` | Monaspace Neon for dates and inline code identifiers |
| `placeholders` | `true` \| `false` | `false` | Highlight `[PLACEHOLDER]` markers while drafting |

## 🛠️ setup & build

> [!TIP]
> cloning this repo to try out the template? you don't even need to create `contact.local.tex` first — it automatically falls back to `src/contact.example.tex` and compiles right out of the box! 💖

### 🌿 clone & optional contact setup

```bash
git clone https://github.com/nathievzm/resume.git
cd resume

# optional: add your own private email/phone (gitignored)
cp src/contact.example.tex src/contact.local.tex
```

### ⚡ compile to pdf

- **VS Code (recommended):** Open `src/resume.tex` and build with **LaTeX Workshop** — `.vscode/settings.json` is pre-configured with a 2-pass `LuaLaTeX` recipe and `autoClean` on build (plus `LTeX+` grammar/spell checking).
- **CLI alternative:**

```bash
cd src
lualatex -interaction=nonstopmode resume.tex
lualatex -interaction=nonstopmode resume.tex
```

## 🔍 verify ats extraction

> [!NOTE]
> always run a quick text-extraction check after major edits to guarantee zero broken glyphs, zero PUA icon leakage, and strict single-column reading order!

```bash
pdftotext src/resume.pdf - | head -n 60
```

## 💌 let's connect!

want to chat about Design Systems, frontend architecture, or building aesthetic developer tools? feel free to reach out! 💖✨

<div align="center">
  <a href="https://www.linkedin.com/in/nathievzm/" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-FFE0EC?style=for-the-badge&logo=linkedin&logoColor=2D2640" alt="LinkedIn" />
  </a>
  <a href="https://github.com/nathievzm" target="_blank">
    <img src="https://img.shields.io/badge/GitHub-FFE0EC?style=for-the-badge&logo=github&logoColor=2D2640" alt="GitHub" />
  </a>
</div>
