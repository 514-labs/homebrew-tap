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
  version "0.5.910-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.910-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b1c9a8df732abe4ab438060b40c5ab73355c85fe0accd8e866da727afc340c7d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.910-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "eb6f20371397cea8e5ac882379777560695ae7e71df51726f4b288bbd918b0f9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.910-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e572ead9d9f4f5015a78c3f61ddeafe59aec78acf16728c10e9140e5406231a7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.910-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cdd41eabccaf811bd7ca4ce61360839638194646c9b449eee81c6911c0f2053c"
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
