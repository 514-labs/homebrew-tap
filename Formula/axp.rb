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
  version "0.5.489-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.489-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "69eef993d214a28bd46635d07270e977308cddb009d76deb8c93c49fc85a9d67"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.489-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "28129f538ea0e49d1af8814ae38bb43b2be6920e8690f39fc044726e69fe9639"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.489-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "82adea6281875b39258d2094891477cab855bfdf1cdbfef6dc51b7b5fa32d961"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.489-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "63aa72e6c128cebb0ddda6e12b5ccc51ca639688d0b57075eb614afdb10c70e5"
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
