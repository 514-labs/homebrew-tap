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
  version "0.5.635-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.635-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d13d672233d3b362860112cc5f96a9bb412fb4f62cb7a25ed44aa5553676f4ef"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.635-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f1fe3bd478a52beb9fc2d9efc5c62727cac0f9514306a3a420646089aaee1b2e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.635-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "06bfb24bda28ba4f49c37a4a1f8ec5f29d428fc60f7cc87e77eb31dbdca4ade6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.635-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "09f350177a96501f4e56424f4e757fdd7e55b19759dd8016b4f7236899a8a85e"
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
