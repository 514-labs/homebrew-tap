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
  version "0.5.864-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.864-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "375bf95a57fa8501744693136fe01af713dbe2ce1b8c2de7960c84bd61703b53"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.864-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ca9dc39f192cf3117daef0713d56698aa2857887cddbd4fb6634ccff7ab96b92"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.864-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "222c639686167c0893e171850a380ea8e38dbd291bb59be2ddf087a2ab3adc1d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.864-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3eb8e0dbb71784cd565e32f6abb4d17571e6dee27afb57cc5fd3b9a49e940e3a"
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
