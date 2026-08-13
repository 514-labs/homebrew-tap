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
  version "0.5.766-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.766-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b7c81308fff648247cd7cf11e6a6afbf01465bb9b707aee57a782f98655ad936"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.766-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bf6166019ae54cfc3bf7654c754bad5e97f4d1da3df114d2faccff9c5ad6bdd4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.766-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "00bcf4d4eab0e0d805c977da46fd90f4ce9a002bfde6f689048d9a9f7ad3fcfb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.766-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9141b436a55ca3887122023e851a35fd3ed9133df0a8f0cf1b8494ec0d7d62c5"
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
