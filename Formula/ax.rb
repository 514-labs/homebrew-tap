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
  version "0.5.285-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.285-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fe9fb2b9e6d5f010b3bbe3c9aa62d3c76e63ada87404b781d0b803ce95191f2c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.285-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "eabab3a1512cc79a01778b9e339b4d0d4a7c851d9a75f8c222db6399633387c4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.285-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cc5905fd52090b4f3c68cc8fd71887535877dc5ee55c71add0422193742a6612"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.285-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ea1c1d633cfc47b5b622b9fbb207d2192fb7bcb639ace6f36993dc55bfe27aba"
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
