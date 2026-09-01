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
  version "0.5.946-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.946-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6a7aa5cbf2380b15c2ad77f3304668e5c36aac22355f8df0ec42ab00843439d7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.946-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "68957af077e67dda10826fa6b35fc02058253e858609554bc3c909cb72f9b26e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.946-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "29879cc76ba8892e871a1ca73eda36e9115113bfbb98b11cbdf0664731a743db"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.946-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a7da2e2fa1e0b3e5bbf66c6a30e159181170bd890caa6e3692fb350be49efea0"
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
