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
  version "0.5.1174-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1174-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ff32e953d0456fa8ee49aaf2c52891a08b57a8f0e3c6ddb22eaf12f002be572a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1174-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f4bce604bdd0ab798d1f8cdb1b24b381205970a6c701c41fc4a231b407839678"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1174-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6c50022518ae5dbc5c1a1a92d9a4763d63b36edaa6f202e3161a894e78b672e1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1174-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "afdb9fcd67c2a0ba826ce1bc2b2e35a44abb0d8caffdcd58135a4f25634cb553"
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
