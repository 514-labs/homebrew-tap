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
  version "0.5.1332-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1332-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "97ab263a84a6c70f44c4dc1ced56d128bd33af3623002b8b79d2e782580b3d35"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1332-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e87ec121e449d0be35ae5694093b13f228a7aaca90ce4cd7751d8f569e6177d9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1332-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0fe51c46a5a2d226f677407415a9e087ff9e9b48ce3c54ce693b4b934b69e699"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1332-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e122cc286edb4f3de1fbc20031489b38608429e2f9c17f4486bc2cc63f24f166"
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
