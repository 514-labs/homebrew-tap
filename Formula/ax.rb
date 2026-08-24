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
  version "0.5.862-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.862-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5d0b02477178f7e32d8ca94ee3ac7ab8360ed6c9796577df2086b8436d50c6ae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.862-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "aeaf6b612d14fb60423088ba5b927616135a0ae6ee9b7227c171f303f29cd065"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.862-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a2a07e3ab687e0f7c516bf961b45f98480322d3415d1c58a316d10d88337dab9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.862-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "06c250b91f2ab1473c8e851e7426fb68c321fc1f511c596b4d8f54ab7cb95cac"
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
