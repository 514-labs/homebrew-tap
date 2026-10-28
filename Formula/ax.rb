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
  version "0.5.1528-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1528-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4a1d6f191c28bc254df33ac83eb7856ee5d260dcd7f159730e91f326f3e68bab"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1528-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c8bc24f622e1c778b827ccacf863767d7c0ccc700a3350ca4f82937707ae0ea5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1528-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0dcbe369ffd6179824f998fe46de479de559840a7c80b43d28e76a00fbdaabc1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1528-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b8ba1222d155265af112547db9065180d4e2d395dc1f2de488c12f4b85650606"
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
