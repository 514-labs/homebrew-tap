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
  version "0.5.997-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.997-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1197015fbdeadf79e842137c3d2be550693521784e262cded3476c2d0ca60cae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.997-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bd3671ba3a66c126463cda616d1c9a79c25043ba8a0af2bc85de422ad8c7d585"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.997-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "06b97e52837c93b2c287ca13979d2a8b3f385750efb50c9eda0da67060020f99"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.997-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "257edafac169e7b4a04e0a4fcc95fddfac2e13dafbb8b4c19cb370e2fa57fe7d"
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
