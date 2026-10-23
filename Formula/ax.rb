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
  version "0.5.1484-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1484-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a11b798634c452c43657455368d729620f30787a317999fe60668394d2249ca1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1484-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "95f256fc9f3b5e6a2b8dc498e89dbe0e3c68492dfdc1994174c3b6f110e10b7d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1484-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b182bb502dac9db733eee20eca4afaf111cab8b92a27f30b5f9a38b64ae54689"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1484-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4b7bf57e8e4f18c0d247fac028c8b006b24145da4cd14f03db58e4b1b5615f0e"
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
