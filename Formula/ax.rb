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
  version "0.5.492-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.492-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2c26071492b8abbb1b84fe7a90881e8d1389716c5f0df074f9e50f9849be3864"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.492-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "50661023e998dca92e361e7a0bd79e9fa6d36a2bef1efefc2fb543249b4fbdd1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.492-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dc24cfb73a92b88ddcbbb5be7de418d0c1ed0dfc3db8524d768187683820b37f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.492-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ef3b7c91b8966de9dbbe057d5460618a8c80e6b3a259d4c2edb7fc884bd418de"
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
