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
  version "0.5.1117-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1117-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "75cf6d4e7028a3a5e99ba5cc0e4fb5b4ef7a19b6e120a0e056cb2091e72b2c7d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1117-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0e03907bf814f7d3f1ae9700b60bd9faded951b389f7e24096f3bbf224d12cab"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1117-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7b4b32883b7b18a3642507b148765b67d26495d91cf22f219c20733b57668513"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1117-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4af32dae9d91b005719fca0ed65e1fbf7d4c94be7a888c307de8508b1825b7f2"
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
