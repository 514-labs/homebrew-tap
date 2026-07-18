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
  version "0.5.276-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.276-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "03ccbfaf869d48c50fc6fe8ab01ec5487d7fce9a358c89a2f927d2801ac73c17"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.276-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e42c01a3bd1045c5005bb8c1c96ea047545eefbc86107d5290dc34dcb8abf138"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.276-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8a2c4c32f882b570a5cc3fd4b3e6cd0e15884099af745daa3e840eb7313777cc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.276-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "011d382241294557a112890c183a3a150ee65226bd50f1d13a004b0b65dbfb75"
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

      Create and run your first experiment:
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
