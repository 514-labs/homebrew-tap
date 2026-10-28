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
  version "0.5.1531-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1531-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1634cd597c47c088fddbca511ebd85e518527e9ead6aaa8fb9217e467f79ec93"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1531-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0187155251d1c45f8495372cea2d86e1a34f4d6d4c118104f502409f59b267d0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1531-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "abd56b39f5096fdb0bf72176f4b170644c49acf240c7439c825d497a9e498ee8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1531-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "58a4f4c74cd88737c54c83c4ff75dcafa42c68689e77d7940823e68c2b69521d"
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
