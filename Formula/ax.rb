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
  version "0.5.1042-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1042-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a895d2b0a3f8286f3f74324e3b9a21ea1b46daffcfaad89069c859c13e8622cd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1042-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0c4a97e6bcad07b0b789ab906fe62734abe52c43b71da5afc82896e027a64fbb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1042-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7788240b1d069dbfd26586f304038ebf2b07101a7ad307b15fd533b09b680ea5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1042-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ea077f4a0190790e7b178c9eaa6ca094117faac32a7d32b21a0f3d43a80a17bd"
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
