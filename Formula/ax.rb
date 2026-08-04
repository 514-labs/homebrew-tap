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
  version "0.5.637-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.637-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cb08ac54d7b77d64009990797ed38e53ab1626a8703571eabcb1a6528f7e488f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.637-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "dae6272aa5e1186f344c728d5757ef95c2a47a0aef7eef0a003b0534f5d98371"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.637-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "05f04f47ac02e00f4def32052630c68b4af71757cda0ffc2db724435872911cb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.637-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2ce6540ae3c0025fc33a72b9fbeae6e5235463f282899080b6660dd031b7debd"
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
