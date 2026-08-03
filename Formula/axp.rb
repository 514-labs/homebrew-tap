# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.605-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.605-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ca023900fd9ddafcf69907b88ea809bf8a152f6093692417df137229bad1561c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.605-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "347c87ece849b17e800dbd19f5f4147ae777f53589b8807f923d735b88019bdc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.605-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b1b2ca2155d5017a2e07006055513661827a87d5708da9d478409dccd98e342e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.605-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bf09cdecbc556e4bc5c3e516b8f8afb5662e920f98fe1f2afcd06ab32486ce34"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
  end

  def caveats
    <<~EOS
      Sign in:
          https://app.514.ax/sign-in
          ax auth login --token <token>
      Then get oriented:
          ax auth status

      Next: walk your first experiment with `ax learn quickstart`

      Already have experiments? `ax experiment list`
    EOS
  end

  test do
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
