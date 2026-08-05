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
  version "0.5.670-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.670-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0234587348fb13b906f63f7d33dddfae21d044b594a575cb962f611a6aa694cf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.670-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "df6f9b5f0776c76e0383eb906f27af2d1dec040082336154471790b88ead9802"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.670-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ed0aaa0611b7c289860f72a35100c674648ee1c781ccb4a0272a5461b94b3de2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.670-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dbbe9d92ce27cbd959ea346673806efa51f0775b24275a51ef9fa25749184121"
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
