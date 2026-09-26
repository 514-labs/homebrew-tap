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
  version "0.5.1147-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1147-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a075961cc2b39acf3c5d3f55c0b3507f2f0c3134d26242826b54a9f2ff3761c3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1147-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "994aa0c2f4322598b31abcdaba493befa922e6e4c8e35999799df36d068927e1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1147-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b57ac58f95f7a27abd5e0e854bb2eca091363f82e4a9cfb3fc0c87bd745c57b9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1147-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d322aaaa86f73471175548377f53e7d7a3d996062de40226fc39ec5a0da8a547"
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
