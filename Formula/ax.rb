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
  version "0.5.1693-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1693-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ddcebd8463bddbce17cef6fce7dd218374e168e2198efc3c65759134bd7b110f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1693-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4aee7190a067394f2027eef7f1ca87b98fa56a612f4ff3cf6094620cf721133e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1693-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "63a8bdc5b0fa7114ab1fffada3f0466e8411fa3cb5da9c7859164a8295b644de"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1693-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "73b69ef9d18297b7bd8a24b078ccf5eaab98b33d2e167384530b8befab14163b"
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
