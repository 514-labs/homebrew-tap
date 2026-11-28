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
  version "0.5.1804-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1804-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "91f6064e4c2a21259aa2b548962ba32afe0667d9c63491794c943ecba755e348"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1804-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "661f891087ec42388deeefb25b91e999e4441826e99528ab2af1144022119ac6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1804-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c7eb1a8ace0b20d4c34df21b587547eccb542a3557bda92c6a4e3ab752404d81"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1804-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ece977b58c6722cb5703db7974e5b12c1fe91fb269d0a21e2d82812b61af6b4c"
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
