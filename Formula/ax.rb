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
  version "0.5.924-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.924-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "00ce020a7308fbc503230214baa37da736000638b40dd091ad32089998421aed"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.924-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b67c65ae12f1e02849ec666d87f873b50e65069b20c28efa3b43ced5c16d4b45"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.924-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b57f978de239ac6bad57393ce8fec26ff6b92ec90ce44eba6d1ad454f49df50d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.924-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6f04f01af20f5f9543cd1d175a8160bc4b5901d5ce80c52f5156e1eca99c04ba"
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
