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
  version "0.5.988-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.988-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6c30cf17c2fc02d95d3d00f1108c7bb4e6d639b96c2377c2d5a8bba91eb7e1d4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.988-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e9e4ad3b88b5f2044d1117694cb24f1bbcf8a3a52944c3bee0c89091bba33e10"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.988-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0dd480bd4784e5f2db9f15c8386a69c27293849a33de54d24f845e704515f2cb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.988-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ccb7ed13722699cb36ea5f9f7350ec748d410e1c6d2dbbf7395be702e5e8e446"
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

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
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
