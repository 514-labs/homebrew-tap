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
  version "0.5.293-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.293-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3c935d3cf8813ff35e38a0ef6ac7c5aecaea7fb079c8af843f643983b89ecd8f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.293-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "dfc13107b0a7dc1df1e1a147e60988864e8f70ca2abf0ad397ccea20ec8a1f21"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.293-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "39cd1c78c161594cd31d84bfe49f75624f967987f6ca8c217ddc7f5e45d5be4a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.293-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e9801721c7be8c6b456209010c2681e8eec8029552b6825dda0f85ca6cfbd260"
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
