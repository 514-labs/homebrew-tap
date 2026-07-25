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
  version "0.5.438-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.438-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4bf875182d87f407ee2ab8d5e89d52a2bb91b4f54a9676144ae16bba21a9befe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.438-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "05d0a10c8b861f4214749709d025f2d581498d5c0dba463a781f2364949a9872"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.438-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2025a5156f1159ab04b5faa957e73c2a5f67e3cf67d264737c27c2065a12404e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.438-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cfef380989741698a3df74846a6c50108575fbb2a857c4b3b7adc1a0d5b2e684"
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
