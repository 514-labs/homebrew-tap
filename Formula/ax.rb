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
  version "0.5.1687-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1687-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f4d9e841ec49f37dfd1e0d67cbc6f4ba257156e5c8847d481e186b1ba13f52ad"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1687-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "df7ab0485012c65a9074d3aeb7fa53ee2e0bc7dc47731642135bdeb810762ff6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1687-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "04bc4f46984f4bcffcce79df3a90ab348e79ff8b8ebca12bb5930b6e55a231dc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1687-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c6e3f41b78fea6dcc61a7f22720c6f94bf86eb8edb9179dd9ac97a05cecb7ca1"
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
