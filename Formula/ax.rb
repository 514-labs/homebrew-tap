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
  version "0.5.843-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.843-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "036d63fd100ae45b8648a2083891070372d9b31e836c6cf92c1fe79936f6829e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.843-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "127d3ad1213047c7b9537318b6adb62fbc1a1111945748d8f17ec6bcefa2848f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.843-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2dde75b4d77a0ae48b22f287f1262afca9f80528708ae1315f0ad5ee4a86f32b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.843-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "37f19f6a81e92fde69b3436ed90f32ea93fca3c7878bae5dcd17a819b95f1ebb"
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
