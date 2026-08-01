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
  version "0.5.588-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.588-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "91e95d2ecd1f81ff6e8cb9643eb579c3f8e8716f8eb0b804dc084c86ae5bdbd0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.588-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0bc20cc497687d7f64a8f8cd7affbea9fce6c287877f8d2e91528debae7fc3d8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.588-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ef337921b9baa9c1301c6e06378f2c2edf9cac053d5ff0b4c7c28fe4bf418f38"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.588-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bc3a36fb4bf05d1a2d107d555c7d50b3c4b5c695a3b4b915d0f63bc8b5961999"
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
