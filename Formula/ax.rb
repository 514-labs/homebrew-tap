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
  version "0.5.805-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.805-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "709a6c505ed60a1585a5f0b8525f145c271c850cb195ad8981afb7d46f492ec9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.805-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9ae3d251d0fe419a6a61974f3845b988978fde12cf6e64dcf57559fb7ba61a7f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.805-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3b43a7cab111d4b715103157e59a86ade28593908d82b019d6c0b6aca7ac568e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.805-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0affffdb3a9eb17ac1982343b673b435dbf01c99178d8597b9b4bb055cb660f4"
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
