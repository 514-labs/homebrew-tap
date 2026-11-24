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
  version "0.5.1788-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1788-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "020c8e22d7556ff4587d3c53e50c3427a5ca17bfcdead6b4a09c60d96f2c9bbd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1788-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "22a29531d30d8379c5813c1aaae2ecd51421b6da54e0339b1494a7d7eec92c26"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1788-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9a8add1578e94b63c44274b52f61bcb82b1a20a4643c63580484a3e282a11a93"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1788-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b3892eb4c6b8d318c54e0be07e586d6af6186681a26217c7de1674d28193179d"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`axp.tar.gz`), whose only member is the `axp` executable.
    bin.install "axp"
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
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
