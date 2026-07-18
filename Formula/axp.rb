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
  version "0.5.275-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.275-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e6d88b2e3df109420d9cdd5f71634ab73a0e97182d2ee8fd00764346603b5b49"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.275-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "021bf82016af4eae0903bfa72dec8e9e4b4cbc3175730d93b642b47f8afc83cd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.275-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7b5299790c5aa4a7ec975a47507ea6733fc4b783c701d30acb2d9885649247dd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.275-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f202a4c8da8f0f9c854313b2db8839ceec70263ca892c58ea714a4b18b62e395"
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

      Create and run your first experiment:
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
