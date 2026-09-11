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
  version "0.5.1023-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1023-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7a7816ef355902e5979c93b1188dd05fbf523f7bcd1567136f80965a867dd509"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1023-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "05d5e2ef0027751e4a3c8e589ebbee88a9303a1d9bb70bce6b1cefcf972c9c1c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1023-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1277692b4f6f423c8263cc950cb360a144c96c2849c22d54879376a4dce218fc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1023-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f20d6d35f746d7f8e165323140ce0df8c1b91c99013a00cf9bce19299243d080"
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
