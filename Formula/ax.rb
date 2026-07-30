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
  version "0.5.542-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.542-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1c6d737dde412139c1f129383f8d83fb12e53eb1de4bc258a1243c5d8ef9d5e7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.542-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "272d90e6f33fff41815858cebd2b6cf8f245b62f500928ed60ce56489a0b2eb0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.542-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e9a9c3389c49c0e94ff932e45c0c0505c5a2844553af995772d2407c96565472"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.542-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0fd998912a7c812d6c137176a53930c2a362b6ec4a17e23d5f1f3b9478057f33"
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
