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
  version "0.5.573-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.573-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "cc3adddfe2aaadadff254c0c68fa1759609b8c66db3461ffc406ed940258e0c4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.573-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "89521f90b6c2954f28c92106d9fc071fbed9bf4699d4a15e808886797b27235d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.573-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "db2dd7bde2b6dfe2a2c2e64e48a176f41bd4e7a09b0c102c7fce0f3469943e20"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.573-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5de042747dd5226523ea2dc1bd3856f9be3eb004b7ba870e3b2169d620dc563b"
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
