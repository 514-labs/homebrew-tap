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
  version "0.5.314-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.314-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0bc9dbe4b6b04f95771422b64b0ba3c0a3f789d5ba9306a303f5d640497c83a4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.314-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0200b749b05a7b962232684eb580bf719a54632b55be95919dd3c011e93abc89"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.314-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "626f6af945b0f16a2c6925678d1189d7404f8ebc2d97340896fde8ea7a4a1c97"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.314-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ca6a51932c09c73cadf4edd3d63a4e864a2ea61428b9de382c7a4badb412f1aa"
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
