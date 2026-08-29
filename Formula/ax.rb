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
  version "0.5.927-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.927-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bff8aa8f2828006a2548e328d28b3348829d5dc48ac04d35bcbfc07b702b277e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.927-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6a6cfb34243abfc1ed083f0df54189ce53b2788164f3b29b88d78c15a507ad34"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.927-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e0605240aaa37c25bfd83585c772a10572711e89a191993682f1778b18ae751b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.927-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e1bb6d179dff4fe342903470f808a6524352bc2a8aa0e8b933b2766c37e5b44d"
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
