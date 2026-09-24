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
  version "0.5.1121-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1121-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "57ce4397a810d2f55be51c7d734f35c0ad4d6eec337de64d92f3b69c09bf42fa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1121-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "cda69a1371520a0ab71f11cb68076b4d881494532db63cbd1f0892efe3edcdf7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1121-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c3d29847887f2487ce5ed2a016efc8eb81ff0119b6b56c76eec44a061a78b19e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1121-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f80da48ccc9be93e7412d2bf671b053b9e6ab43a6d8f94083c172cef1ae8b0ac"
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
