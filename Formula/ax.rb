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
  version "0.5.918-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.918-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "340c1d7d5a91204efd73094c3ec2e136e80d0e54b994af6996559bea005d9e7b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.918-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9f7aae5c61efdd0d98db883b459e268cd837be6e9bd8942d22160170d1e267fb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.918-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c1e82182114fe7d2841a07216b2f31963a180e137baba6892d11b9bbd271951e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.918-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "77f163805fa1f281b9298f59345eb904469bc4bffc7a91af5a51e3cc74825d9d"
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
