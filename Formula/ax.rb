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
  version "0.5.482-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.482-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d9d18fd42821b4a904770db7a6329ae0ff7bfc8f5e58f06918f01101eb46840b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.482-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8d1a516536da6da9c951969e83ebb9af94ca500774504c603870f3ecd90e3741"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.482-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "91ac0d65b62d9b63d4dbcefba95ea044b9996b2f278e771a60c13aa4b5d60b88"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.482-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5ee18658f506e371e79c023e408adb05e529d49231547b5b4065564e8b15ffa9"
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
