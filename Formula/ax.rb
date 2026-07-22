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
  version "0.5.363-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.363-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b9231ff072fec13ea12785e1e14ac731938766b5b00f9a8e98e65ece846cdc28"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.363-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7850188589b6add0185e2e89092dc14d882cf70586e3dfce26a57675f04a2160"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.363-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2d89f01c0b1665a99f5d89d6244e5a06f6c88480b41fa2b8af5750bda10bb0b3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.363-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7396ddd3adacd3cd921705fd436a32ab23a8f6f8743284d578f6a068449f1d28"
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
