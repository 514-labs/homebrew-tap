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
  version "0.5.872-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.872-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c020a41e660a5d07c3a6d47b9a7cc91a7d8efada72854af4a449650efa49bce4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.872-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2027dc2af7994db093ba60d92cc9f347e1a8463607a2c81f7c117271dd6ab14c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.872-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0a97426971f186d8141f19e5d28b1a1c3507f238e8890dd1a25f990f5a5905f6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.872-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5ed8f895732e897b7e485f7359b4daa7604d8e16817fb87dc0ecb7b7d1554c5f"
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
