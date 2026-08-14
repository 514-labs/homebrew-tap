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
  version "0.5.784-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.784-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fb55b6e5ffc43578591b921bcdef90943ae6fd2c3702cc2ff00acfe1616ba14e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.784-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "053f71d5919264b7aa7bb306c727b6b29c3e557e706c764789c619fbbc29b565"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.784-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "939065417d280b6276b2f78c553dbccf91a12ef655d99acb14817f0f34a3c55f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.784-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a660a84ac034a9861897b8a1217ba954df4cf6a5ad90c41177e92c887637dbdb"
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
