# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1307-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1307-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "19ace429cb392691650dedfb3096a88d900e2cbf2e97a32c4c033572b957c07d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1307-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "47d6ea8cb27104e0a86b8f85d930b41a636a31edf2cc77f161ceef564c94560f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1307-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c13ed4997dd04df63f68445074a44c6c8409768a1d041c207978815faef18fc6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1307-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "37fdc7f27a6107706de0162dbbb75a77887448fea45804dba61670117b64dc5c"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
