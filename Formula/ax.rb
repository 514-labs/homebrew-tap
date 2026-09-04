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
  version "0.5.961-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.961-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4112b10b4f90ac5bd7daf856e14d40e1ca3a4452578cff451181718a1b15a1e3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.961-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5564ec24830b862aa59542135aeee84ed74bc5b9e41d5ed49d62d7d2e304d846"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.961-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7139286bfee0c4e54932f884971b9d75aea4cfbf9de889124184115d1de1e6c2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.961-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8b31ad45753f09de779bf8127da7cebec45e441a6be7a2bfb3d2df3c05053b6d"
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
