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
  version "0.5.1223-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1223-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f8063dc811652dd6720a018c7a9c8918f3ac28c60527d3bfeba9c4ddb2ac9a93"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1223-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a41e034aafd5be1eb8615b7dadac57500d1728a8943cb098eda8913e520ad8c4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1223-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "323fb8e54018f9197c14f54781279ac59bcd29561547fd794b2b419ac3dc5402"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1223-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f04cf890a0d6fd78d83bbc526875231429a51093a0edde92e547d6227f10f897"
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
