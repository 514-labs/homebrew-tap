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
  version "0.5.1202-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1202-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "61a6fcac35e9702a810356be40edef6dc090d1060652d8e9eb83511df925f0a1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1202-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "684fd644e57421155d89b5691bfe8ad7813a608b2b2adfd7ad7ab56fe9f2318d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1202-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3daf7344270778ea37f1a0140485d20c5585ab9c84f52ce32ba9c75d3c24960c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1202-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ea72ac0410b22efca88727257947ff4e4f3ac8b83e164765bf9018f70c581bd8"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`ax.tar.gz` = `ax` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ax"
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
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
