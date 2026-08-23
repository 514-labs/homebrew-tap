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
  version "0.5.853-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.853-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "420eb62f5cb89c7d34c1a1e705cea318d4f086ddd73832040684887d3bf7a34b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.853-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "54750fca05606b8ca2d03a7903a31145b988c475f529983ca18f716cc18f55e3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.853-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "91b862f89502c2f7906ded95e62f0c7f8b754756ef2cb640124a973d938d7afe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.853-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0a18c6e5b503a691508691bf8f0ce7653dd511fac22b6b33d67a8830359c1d55"
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
