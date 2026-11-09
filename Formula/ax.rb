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
  version "0.5.1694-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1694-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0c1ad78922f312982d06d8002820e1a56d92e11259012564d1ce39230e08f1c6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1694-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5648e3ef214aa5ac94404d819ba4092985d6ba175c4a2509a5c2f866b11c0619"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1694-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0528722900f31b5c05b1e1d13d6e2031402c6c180ea24d0cae9b2f5322b955e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1694-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d5aa1f8cf4d0f78b4d9461e7165ca2d28242f6f349ca58d72e1cdb1d464baeb9"
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
