# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.485-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.485-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "319103a8261b2aef2c94904702e2e09ea1e0e23dddc6c8c2eff48a2a1a2b54e9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.485-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a2e4079ec5aff92e2f8181f1e66e7112e862bc6a2346993ce1f700a0ed28e1a9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.485-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "af3510235df663be1069868d909bc60b2464b13564501fb0daef8f3008a3b2bc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.485-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e6adc62c7a0bfe7c9e6fed97476d92bbd08d30ae1cb720fb0c53dce041f5927f"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`ax.tar.gz` = `ax` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
