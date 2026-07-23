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
  version "0.5.391-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.391-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8838fe8a66d7724ef0c311f561d307dfe4348936af9df39ba522c140528c7e0b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.391-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4d71fe331f849124a226bb92ff7960f6ac85387a82d54df1a6baedb9d9bbeb70"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.391-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b1f577ebf337bf109b31d5b0f6416b946c3fdb27da6bb052fd4e7205a0ba3a31"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.391-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4f580c4cb196b31b6e4159cf50ff328f0138c11460121146db26c3f9ab7fd816"
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
