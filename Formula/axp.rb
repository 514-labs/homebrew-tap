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
  version "0.5.447-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.447-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "97de3deac07eeb0e3ad06b265bd7d63b24917a21d64b4c63cf59788ba2243597"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.447-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "16f02fab8a8d0697eea0efbf1eb47f86ca07b3649b7833e65a58a34b1d79bbbf"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.447-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f02d49ec9de97bae983bf93480f61224aca0e3b9c7b5f8edb268833abaf22167"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.447-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f51aafd478f0641d2711a0f2e04b76b7c16811ff67f4a36763f70cce4d7fdc71"
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

      Create and run an experiment:
          ax experiment create my-experiment --template cli-install   # your agent writes the YAML from your product description
        → ax experiment validate ./my-experiment.yaml
        → ax experiment run ./my-experiment.yaml                      # smoke: 1 repeat per variant; scale with --repeat 5
        → ax experiment query <exp-id from run output> --metric testPassRate
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
