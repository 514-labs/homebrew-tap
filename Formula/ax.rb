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
  version "0.5.1422-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1422-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "91f4fd4e48a23dd97cec6a47f9b4e8ab2cb3c959abf0ee8a4de77080a34f2ce8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1422-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "46dbfa620a8653beae1420fe4de6e5472ec5dde5d35a0c1865dd8fdfdf71fe71"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1422-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a1dcbf72b887ea97ec9af70c09cf78d1188471f81ef18374734478fe5eab85e2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1422-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "438757e4b69bc57bd576d9d1936344393e316bada8c2f1482a5339a4b7bb0285"
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
