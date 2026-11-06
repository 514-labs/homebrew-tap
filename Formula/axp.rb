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
  version "0.5.1651-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1651-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "96696e89b8b47991bedc9ba96a27e5e053ff47d820b44249eeeb05da656273ca"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1651-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f2f33d11cfcd99c3eaf7548aaaffa6cb7a86909cf2c83f03f79f94bd388ae980"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1651-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6060cf85a755e72584138da94559e83ac190c3c877d34eadf3010e2802dc43f0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1651-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "827148b5374406210be072c1f50e8fa4fce4a63bb04300951597c6f4b1ac9568"
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
