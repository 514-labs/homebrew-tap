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
  version "0.5.519-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.519-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c1b668e09f018113bb9b79283ffb1b953accea8cf292e94e3f85296319c4df22"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.519-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c5950cca768a70ca468bf1e47b2b7102d5fa1c3518f63b6dad73709c42332f1f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.519-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d49a14f14ebecf061ad6fb7c79360369df391b07c56329fbe76d6588b0c471b6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.519-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7ebe1217e34b2279b9a29501be23a36608c35428be76e9f737c37a0f05201624"
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
