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
  version "0.5.642-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.642-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "83029e3c7aba13fa1bbf609bcd8d0202432c52191e01f6df9f058ccc72520703"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.642-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7ba1c3ee17751b2fef12d80666b21e671b47599eb4b6168d2c521a462e0674f0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.642-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e9f7d1dee44e071e681fa995b4be24642506d037603ce379f8deada7355a0888"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.642-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "15e2e5d8c479fad7f301eab9744ea01318f87fd5c96d11a826324536a6063ff6"
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
