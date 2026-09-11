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
  version "0.5.1012-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1012-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bce24b37f4078f0d3fba3b7f908722aa6902767869df7d238dc3ab99cac516c2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1012-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ea5e005e1f74fb05f632a5708579c6f23f4f0fe700b73d235d1fceb2188e6dd9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1012-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e0f42e9bc3dae68629a51bb22eac034c99fee138cc3898b3e8bf1f5337b5a550"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1012-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "04fc523187d1857a375fe7d07e83cb8107de19f64eebb2f638df6270dd5943d7"
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
