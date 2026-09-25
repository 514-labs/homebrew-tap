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
  version "0.5.1136-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1136-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9d7318983d71668c1e078e935157b453f4c01bf272a76e31cca361c02d649d85"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1136-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "999f19d45d383f9ff3d8480cbe0fb49044565d846d09295f5a6f37dc02610a5b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1136-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a02215db2a6de44a1b8218950c4b2fb8202496ac0b8d590d0e0dd3351ef10dcd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1136-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d77132d109448786d329de377ea3f3bd8983c0acc8f06d69300f0c0cd6be937d"
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
