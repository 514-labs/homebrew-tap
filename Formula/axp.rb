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
  version "0.5.589-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.589-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "07be8c087701f076e33f8bae6335c3243f1e6935fb25f6939c549d1d411b9337"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.589-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ee0470c85cf83140b7fcc2f027e75e3c76be5cca55cd158af3986ae90c13d210"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.589-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ce5aedae3d59ded554f66454b69783f31a0874984f86351b502cbf48ad79a240"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.589-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "30eeb3bff9c90a6ed785d874c206476594af99d9e1ef310db81796dc3f4f20b2"
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
