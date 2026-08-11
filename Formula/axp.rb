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
  version "0.5.735-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.735-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0eb6f5a8c8ec894c30a46f77019c2799d6e197619f35a8b8bf170371b99b0d62"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.735-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "21fb509cab0c8d08cbd1e708d8459c1736189f0fbddd0a473c9edea3e24c0769"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.735-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "41f02209e8d33fbedffd2e0065c26a86ed8be178f60c1ea6b11b561adc6f3491"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.735-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "90798d49c12d68054e5bd0f2cb776894cd13d973c194263fb85324f6331cf13a"
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
