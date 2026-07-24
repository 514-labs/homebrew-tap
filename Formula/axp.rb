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
  version "0.5.399-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.399-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "00f358823e6df32400234451f76d25d331efb2c77e5bd24ac898aabd85318898"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.399-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "44c97e04d19605a325675b18e520a6821e17db8c5c737b48cdf72855ce8755b6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.399-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f56505a1fb8e5b2025761f74b57b96a46134b3080cd8eaedcdca60c3741d5aa4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.399-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bc93b791e18b29b9e18bc976d368dacf5b9ca3f016acff85b17e1dacbc6bb256"
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
