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
  version "0.5.387-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.387-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b5a0c9f7559fab4b3792096ebfc6c813dd9a7f93a84a1ea91ba5256b31ee83dd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.387-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "df50decab26a6078870c193a9c6fac027c7564d1db88959637830cb6f51c555f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.387-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6b2cf4828831bc7c48d59e257444ecb75ef89ab87754d88cffdabf186fef104d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.387-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2fbcc63f7d3bef98d4ff3cc704ad89159f4c6ca2e1fb1c2e46d7db6466260438"
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
