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
  version "0.5.772-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.772-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "053ff09e7588e9639682e899652075fcf175c11952b23021c15de8a85eb8955a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.772-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7f8817a478173a7919ae169142a9dc897435bfede18c30cddea2c6ee3d8e0a56"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.772-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5e11b8b2d5559653d25b4b32aca473b83d3a26b66e8d6012028ed792e0c0b5f2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.772-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e19f7d218c93f99edb2ac82a76eaf97010d4d0e25731f44bcc6336512de04748"
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
