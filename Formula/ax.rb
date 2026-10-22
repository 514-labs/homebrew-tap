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
  version "0.5.1468-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1468-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ce827bb72ec15ac302eeb845f6e93ce4616b25d4f6067e454d11616937d16d35"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1468-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2d0e90741c6f8c4f540095b417cc56798833c96a94b1327c29707adfe573bf66"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1468-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9efc91a0670a98192d8630c1f4f84b58cd09f483a6fda92781dd20ed79367ad9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1468-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7c2c1726942944edf236c0072eff65b2cdfc251fc238999af03556aafbc1f305"
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
