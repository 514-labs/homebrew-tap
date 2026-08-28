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
  version "0.5.920-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.920-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "57c92436b8ccfd028427203fa4f8241d2777c66c2c5457e563e675c3974f9db1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.920-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d24b8a7ca63c7d308385073065c1884db98db0337f1ce1914c1464a4ec43c021"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.920-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8ad96eb6aefe1784c76602e6bf60e17ef1a3b48c6fee6bce677e6f97d880fae8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.920-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2d7e8b72486fe909380eb7c9a697cb2ad63f95fc75202d629c25586e5f7d4931"
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
