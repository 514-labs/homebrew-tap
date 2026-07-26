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
  version "0.5.450-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.450-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "857075349106be3917bdf285461a7289cd501e92c95db1505c4b390578691193"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.450-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f528eec8f3de3f186768fb855799807904a8641a92652ed68811d8d81676e55f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.450-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b1fc46ac3b860856beeeef0703a7ef03d4df18304785dc991639079c18276513"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.450-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5232893af283577a8b1f79fc32acd61af3515836338d56df4700b276d6d57549"
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
