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
  version "0.5.1414-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1414-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "945d37cb5afdffa597eee38e11c873464f5b239440c2224504d00bbf1ba9e191"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1414-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ba8b61ba41b25e42223d9508e18461a44013617bdc8c2772d8fcc51fbfbb023a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1414-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "51985be0688a3355b9db66c274ec7b8129c5e55320bd594cea82d4f3a9f47a73"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1414-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "21e652cef91327803a9a6eb8fedfce370b1742bf48a0bff052e8f2ee2688d559"
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
