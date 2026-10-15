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
  version "0.5.1368-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1368-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cef7959096500a907131036b4d2db5ee74bf632f95fcdd54cd56690c95fe4e98"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1368-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "664f246b2c0da42307aa60df17325be8882851e17bf57d86c9795701def584c7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1368-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4d3e95fd86e85c0dba21d946a39e94ce2b955cba07dfa10ed75634ab956e0936"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1368-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "59ed11260e6a7e232971e061299eee032b61a147bcc15f227ac0b4248e5a0ee9"
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
