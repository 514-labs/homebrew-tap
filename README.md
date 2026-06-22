# 514 Labs Homebrew Tap

Homebrew formulae for [514 Labs](https://514.ai) tools.

## `axp` — the agent-experience platform CLI

```sh
brew install 514-labs/tap/axp
axp --help
```

Upgrade to the latest stable release at any time:

```sh
brew upgrade axp
```

Uninstall:

```sh
brew uninstall axp
```

Supported on **macOS** (Apple Silicon + Intel) and **Linux** (arm64 + x86_64 via
[Linuxbrew](https://docs.brew.sh/Homebrew-on-Linux)). Homebrew downloads the same
signed, checksum-verified binary the [`curl | sh`
installer](https://docs.514.ai/installation) uses, from the public
`download.514.ai` CDN, and installs it into the Cellar so `brew upgrade` /
`brew uninstall` work normally.

### Scope

This tap tracks the **stable** channel only. To install a specific version, a
dev build, or a per-branch build — or to pin a version with `AXP_VERSION` /
`.axp-version` — use the installer script instead:

```sh
bash <(curl -fsSL https://dl.514.ai/install.sh) axp
```

See the [installation docs](https://docs.514.ai/installation) for all options.

## Maintenance

`Formula/axp.rb` is **auto-generated** — do not edit it by hand. On every stable
`axp` CLI release, the `publish-homebrew` job in
[`514-labs/axp`](https://github.com/514-labs/axp)'s
`.github/workflows/release-cli.yml` regenerates the formula (new version + the
four per-target `sha256`s) via `tooling/scripts/render-homebrew-formula.mjs` and
pushes it here. To change the formula's shape, edit that generator, not this
repo. Hand edits are overwritten on the next release.
