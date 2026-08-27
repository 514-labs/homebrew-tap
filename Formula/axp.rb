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
  version "0.5.896-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.896-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f2b3f018fecf09fa453cf9b91a880285db58c7eb00ec0693a219c35ec1352572"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.896-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "03236bf2c685a6fbdad890309e24e3b38d7ac774c06bd14b34cffb77146af270"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.896-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a67044a7c852cd3e98af7df22d48c99638955b47aaec0ee6da3fc4d9991c9d26"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.896-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "417e6b47851df72b0858b7d415e2d53e7112b142551d8104476b72ac39166070"
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
