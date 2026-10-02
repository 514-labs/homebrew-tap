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
  version "0.5.1231-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1231-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3df999bfcbc7463296dc6c4c28705b88cd5e85c602fc167aceb3e7481f4a54a7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1231-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2ac87239757a2c7a07ab1257fb04eeb98d1bd8f530d4b79c5b40769bd885cc23"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1231-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2747e13087c3482fe3fe0700f2ba377b9f6018bc7b4285ee695a0692765bf29a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1231-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "91f1f6c4e1ecdc6129daf6d9b128de2698cd566f52eed1156d1d41d4e6d5fc6c"
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
