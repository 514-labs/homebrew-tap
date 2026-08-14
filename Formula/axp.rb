# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.776-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.776-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "cbef8cffec231efca9be18fd271702c298117bec4f1d498aa76f0bb54b0e38aa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.776-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "516b47a3ac0b0350837cb4d4e51d4fc28f6757951998d2d5d81a29aa614afc14"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.776-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8e03e2532fdf360fe31b81001d8ea58c3b9a8f377589eacad7b53644a88fb7fd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.776-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f47976222c690749743de1fbd4a3dc75922f2696d4790b6f8e9ef74bafc78791"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
  end

  def caveats
    <<~EOS
      Sign in:
          https://app.514.ax/sign-in
          ax auth login --token <token>
      Then get oriented:
          ax auth status

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
      Already have experiments? `ax experiment list`
    EOS
  end

  test do
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
