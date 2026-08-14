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
  version "0.5.790-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.790-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3b771b44a6abb36ec1a6c5a22d7b248a0496bd843fe98948c50680db7d2b430b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.790-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "239806c6558e9952d0999602c896ce927f457132db2106a5bd51a311c7395940"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.790-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b002a1a5f3281a14de8ee53f1bfa45f92af2f5daf2a7347e7385f46f8f4150dc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.790-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fa5a1e107bf8b155006dcbc79994ec7f6f4a644cb1eb92311ca4682dfcbafe28"
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
