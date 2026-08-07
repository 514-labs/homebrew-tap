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
  version "0.5.706-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.706-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "abc12c1fc4a35456c87763924d0eaddea46428e4a0d69ffb8e0eb780c49607ca"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.706-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d2e66b6ec878593a5dd6e0809657ac4ac7abf3ea35513fbdc955601c0fb591bc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.706-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ae595e2153eff8c374aca02017c3bfeab0928d416f9b996425f4e7acbb9c56dc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.706-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4557e44ce88e82e2b2b4f2e5f2e56914540cdce1bbdd24011a0b2539f446368e"
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
