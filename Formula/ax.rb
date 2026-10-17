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
  version "0.5.1404-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1404-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "783648d8964430bca80f695396673f9a2461753e39d41c34bcd5d50a5b94a30a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1404-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "142271f9ae3aaefdf396be4c19a31ca21e797cbe6e7580b611a2fde7335a03cb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1404-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9e5778a43dde4e159d7cddabac15cb1b7378213a009bdb91cce0f989246984e4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1404-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "384d7bd89da9321b2a69985f734395d5d631fdc3f8052f84ee60b1a5a0ca97a8"
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
