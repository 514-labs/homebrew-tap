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
  version "0.5.1303-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1303-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "822aaa5ac034a82cf01ffbf6d678b737bacd661437a13d63b38650edac528d45"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1303-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9e747e884fbf40d487cdd6f06cfe5a695934646a0f7022001a317b6e73003cf0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1303-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c3819ae5eff1e5efe3c4ccdd4fd80fbb0ca9898d57519e44d1c93ad5d6fb5046"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1303-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b67ce14cb787351dc54b96815c488fe9d9f7476e48b257776b98e11eedec948e"
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
