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
  version "0.5.1068-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1068-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "46cb3d1f9b1c36766dbc0cb1ba7aafad4a15c702e5bc56f25f2042f03098ccc2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1068-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b2c14ff39bb3ecb3b5e2cef73a3322eeb869fcdb2a700704915b50fa2b04e0ca"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1068-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e3fa161967ac7f5045fbbf8e932a0616a1abae1cded9ee2c4be41bc569a91048"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1068-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5e01541330c751c1f87091b06b6e73fd5de4f59729b63e48be48f63b4efb9369"
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
