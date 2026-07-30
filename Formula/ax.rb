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
  version "0.5.546-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.546-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d2aed6d2adf9c17034387ed386004c0c7cf2b8361c88b143e7cbcbca32ca31ee"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.546-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0ec82e7273332e3ce397a6f704d22b48d0e9939eca838a0b196290053808f36d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.546-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f19e09984c6e61348fbfa25c9385a577a3235ef7f9edd4d8a40a8a80352f00bc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.546-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c3c45d9b3939c45e8763c0dc7ffcfb4b021d8adec1eef7ab355e0fbe8a033854"
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
