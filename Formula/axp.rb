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
  version "0.5.350-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.350-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "df63c5cd607bc7d1d29d04ea14a62afa17d0ca3f6785126dc918927d91a3f74a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.350-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "51b325338058a0f95632e2a465fcdc5b992076e901550e217f894b96a75d6996"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.350-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3e36edff735df02f96a8aa03f5b9c94ec9383e9e31a68729410eae8ee7ff566d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.350-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9408bf536647a245d5ff67d29977082b0b5c59ebe6b3f8cfb88657b7c0f1550a"
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
