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
  version "0.5.1703-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1703-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e80d01f077b3a07f839ac0bf142f84bb0d85bb7463272ed507f92aaa74b4ca54"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1703-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "86531d7a68e2b9ec0d97cb4391c105046de34594a919671b60fc41556cd10257"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1703-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "243b198eb584d938213d5b1ab0fd8dced771cc863c86268072e6e2068e1bb869"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1703-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "70ea72c03e025c9fa3e1e23b2a52b9a5ea16a337d7aadb8bd793329e0c25034b"
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
