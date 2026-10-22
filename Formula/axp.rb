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
  version "0.5.1460-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1460-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "380e1d67167e54af860121954090a793729279ab51bb21a4048ebfca27e84369"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1460-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "3eed73bca45f830f339128cd77202ef50bfd778a1eab474c10284fb347b48b39"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1460-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "365224f9303c33225812cb6f79587874d5e950bae15317d0f772ed8b1f83ae97"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1460-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "79e712df15690ce1d76c16e19f369f2c251a9127be9bac727ba9d422c7afeb79"
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
