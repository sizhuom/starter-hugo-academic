# Repository Instructions

This repository hosts Sizhuo Ma's personal research website.

## Site Structure

- The deployed site is the static site in `site/`.
- Netlify publishes `site/` directly, as configured in `netlify.toml`.
- The older Hugo/Wowchemy files may remain in the repository for reference, but they are not part of the current deployed site.
- Do not reintroduce Hugo build settings unless explicitly requested.

## Editing the Website

- Main page: `site/index.html`
- Styles: `site/style.css`
- Profile/CV/assets live under `site/assets/` and `site/uploads/`.
- Publication paper files that must be hosted locally live under `site/uploads/papers/`.
- Prefer simple static HTML/CSS. Avoid adding a JavaScript build system or framework unless explicitly requested.

## Publication List Conventions

- The publication list should follow the order in `site/uploads/cv_academic.pdf`.
- Keep projects and publications merged into one `Research` list.
- Each publication entry should use the format:
  - thumbnail or placeholder on the left
  - authors, title, venue, and auxiliary links on the right
- Preserve inline author markers such as `*` and `+` when they appear in the CV.
- Do not add a legend/note for those markers unless explicitly requested.
- Use existing thumbnails when available. Do not copy thumbnails from other personal websites unless explicitly requested.
- For missing thumbnails, use the existing CSS placeholder style.
- Prefer arXiv/CVF/ACM/publisher links for papers when available.
- Host local PDFs/supplements only when there is no stable public source or when requested.
- Do not download and host videos by default; link to external videos instead.
- It is fine to copy auxiliary links such as PDF, supplement, code, project page, dataset, and video links from coauthor/project pages when relevant.

## Netlify and Git

- The production branch is `master`.
- After a PR is merged, continue work on `master` and pull the latest changes before editing.
- Netlify should not need a build command for this static site.
- Keep `netlify.toml` minimal:

```toml
[build]
  publish = "site"
```

## Verification

Before finishing website edits, check:

- The publication count still matches the intended source.
- Relative links in `site/index.html` resolve under `site/`.
- No large videos were accidentally added.
- `git status --short --branch` contains only intended changes.

Useful PowerShell checks:

```powershell
(Select-String -Path site\index.html -Pattern '<article class="paper">').Count
```

```powershell
$html = Get-Content site\index.html -Raw
$refs = [regex]::Matches($html, '(?:src|href)="([^"]+)"') |
  ForEach-Object { $_.Groups[1].Value } |
  Where-Object { $_ -notmatch '^(https?:|mailto:|#)' }
foreach ($ref in $refs) {
  if (-not (Test-Path (Join-Path site $ref))) {
    Write-Output "Missing: $ref"
  }
}
```

