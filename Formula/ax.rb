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
  version "0.5.418-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.418-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e06f56b48224b98ce4ac952d84262363def03bec5074b152a14bbf93a31dc5e6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.418-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d050031a731ced45db4ad742418c8b6034fe0d46e5728b1ef185603150079644"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.418-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b8ac3f09e17f07c6c4a3545db49dfaf8a18cffe47caefdb63ec3e2267281bd98"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.418-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7e72da77338c96475364bd3559d1e055b3510e50f1fe261c1a1d28e04a70a75c"
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
