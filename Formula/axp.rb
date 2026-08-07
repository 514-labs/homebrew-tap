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
  version "0.5.708-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.708-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e3f8869afa88b837ecd88ef820aa667d86a8b4bd906909068fb8dafaef295008"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.708-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a80300ecfaa9bd702386d5ad1ca643f8890ea23e628ed0013469f6014f7adccc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.708-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0daffff3f3731ad8ec393ab2dfe7d7d0c04abdd68726385e842dd276cef0bc97"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.708-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2a602a10a9f59c3a276cdc97430df4fb652c634064b39c18e24e949bde1fd3f5"
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
