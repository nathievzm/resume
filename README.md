# resume

ATS-proof, single-column Software Engineering résumé built with **modern LuaLaTeX + LaTeX3 (`expl3`)** and a modular **Design System** (`tokens` → `components` → `sections`).

## Architecture

```text
resume/
├── build.ps1 / build.cmd      # Clean 2-pass build script (outputs ONLY .pdf in src/)
├── fonts/                     # Local fonts (Sora, Inter, GitHub Monaspace Neon — used weights only)
├── src/
│   ├── resume.tex             # Main entry point & \ResumeSetup configuration
│   ├── contact.example.tex    # Public contact placeholder template
│   ├── contact.local.tex      # Gitignored private email/phone override
│   ├── styles/
│   │   ├── index.tex          # Style barrel
│   │   ├── config.tex         # LaTeX3 key-value config engine (l3keys)
│   │   ├── colors.tex         # GhostWhite + MidnightViolet + Strawberry Pastel tokens
│   │   ├── spacing.tex        # 4px-grid spacing tokens (converted to pt)
│   │   ├── fonts.tex          # fontspec declarations (ATS-safe ligature settings)
│   │   ├── typography.tex     # Modular type scale (\fpeval) & semantic text roles
│   │   └── layout.tex         # Geometry (letter/a4), microtype, enumitem, hyperref
│   ├── components/
│   │   ├── index.tex          # Component barrel
│   │   ├── icons.tex          # Solar Bold Duotone SVG paths via TikZ svg.path (zero PUA glyphs)
│   │   ├── primitives.tex     # Orphan guards, separators, and shared helpers
│   │   ├── header.tex         # Hero name, target title, and contact links
│   │   ├── section.tex        # \ResumeSection[icon]{Title} with dual-weight rules
│   │   ├── experience.tex     # \CompanyGroup + \TimelineRole + \SingleRole
│   │   ├── skills.tex         # \SkillRow for structured ATS keyword matching
│   │   ├── project.tex        # \ProjectEntry
│   │   └── education.tex      # \EducationEntry + \CertificationLine
│   └── sections/              # Pure content modules (no styling clutter)
│       ├── 01-summary.tex
│       ├── 02-skills.tex
│       ├── 03-experience.tex
│       ├── 04-projects.tex
│       └── 05-education.tex
```

## Configuration (`\ResumeSetup`)

Edit the single configuration block in `src/resume.tex`:

```latex
\ResumeSetup{
    paper = letter,        % letter (US/Americas) | a4 (Europe)
    heading = sora,        % sora | inter
    layout = linear,       % linear | bento | classic
    datepills = false,     % true (soft lilac pill badges on primary dates) | false
    companybar = true,     % true (vertical accent bar on company headers) | false
    icons = true,          % true (TikZ vector duotone icons, ATS-safe) | false (pure text)
    timeline = true,       % true (subtle vertical line for grouped roles) | false
    mono = true,           % true (Monaspace Neon for dates & code tags) | false
    placeholders = false   % set true to highlight [PLACEHOLDER] blocks during drafting
}
```

## Setup & Build

1. *(Optional)* Copy `src/contact.example.tex` to `src/contact.local.tex` (gitignored) and fill in your real email and phone. Without `contact.local.tex`, the document automatically falls back to `src/contact.example.tex`.
2. Run from the repository root (`cmd` or `PowerShell`) so temporary `.aux` / `.log` / `.out` files live only inside a temporary `.build/` folder and are cleaned automatically:

```powershell
# Compile main resume -> outputs ONLY src/resume.pdf
.\build.ps1
# or in cmd.exe:
build
```

*(VS Code `LaTeX Workshop` is also configured in `.vscode/settings.json` with `autoClean.run = onBuilt`.)*

### Verify ATS Text Extraction

Always test the exported PDF with `pdftotext` to ensure zero broken glyphs, zero PUA icon leakage, and strict single-column reading order:

```bash
pdftotext src/resume.pdf - | head -n 60
```

## Modern LaTeX / LuaLaTeX Features Used

1. **`l3keys` (`\keys_define:nn` + `\keys_set:nn`)**: Real typed key-value configuration in pure LaTeX3 without fragile `\def` flags.
2. **`\NewDocumentCommand` & `\NewDocumentEnvironment`**: Built-in modern LaTeX2e argument parsing (`o` optional brackets, `m` mandatory, `s` star modifier).
3. **`\fpeval` (IEEE 754 floating point in kernel)**: Exact modular typographic scale without external calculators.
4. **`fontspec` + `Ligatures=TeX` (no `Common` ligatures)**: Uses local `.ttf`/`.otf` weights while avoiding `fi`/`fl` glyph ligature traps that confuse older ATS PDF parsers.
5. **Pure TikZ Vector Duotone Icons (`icons.tex`)**: Renders official 24×24 **Solar Bold Duotone** SVG paths via TikZ `svg.path` instead of Private-Use-Area (PUA) icon fonts, eliminating replacement characters (``) in `pdftotext` and ATS parsers.
6. **Zero-Dependency Orphan Guard (`\CVNeedSpace`)**: Built with `expl3` dimension arithmetic (`\dim_set:Nn`, `\dim_compare:nNnT`) to keep role titles and section headings together across page breaks without extra TeX packages.
