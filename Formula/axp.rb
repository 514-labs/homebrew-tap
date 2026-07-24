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
  version "0.5.411-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.411-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9179ae2a602546f3a68064e1220eb3d63aea3eddc6c58b672f692aa2fb3f8d1b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.411-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b65cc416407f946e67b6d4de334538fc2c7dd4872b043e8b5e7f2d7d1574dc2a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.411-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "181d4cd853ae666d81740df10ed6825cec290103fd625ac0ec177a80a89c9828"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.411-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1210ce19f572b118890269317783d60d2cb36810767abab7f7b113e960dcefa4"
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
