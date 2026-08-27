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
  version "0.5.903-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.903-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6f8936ef4e09538c6b24e29b8aafc4123bf745033fcb3d90649d374c76484d75"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.903-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0dde04fb247c2340a0515c53d5f54cd879c655bc8c811c07beb9d29a7ed8e063"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.903-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3d63f7be6180759b37afd13fd7800bd7bc468fa425858674ea437468342750c2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.903-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f765c9ae4a7432dcecccb931822b153c282c29a99c2cf1de5de78d1afe8ebf0a"
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
