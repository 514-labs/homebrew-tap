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
  version "0.5.451-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.451-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "15825f96183cd5087240b186bf6c98058ef89671f326f13c957b046ab561628d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.451-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2d22d71345620f534d199e62139bfb7161509b129cdc245358f6ce6a6a66b96e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.451-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "463670c5856f246c52654e31be8f5dae0ac5f158ef3e444ef2cb4231502b97e9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.451-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "956c3f7839f7c8a10aa31fb353513d999d1a461efbcb57f0c1207cb99c282a32"
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
