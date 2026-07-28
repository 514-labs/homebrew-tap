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
  version "0.5.483-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.483-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a10273b6820f4c1e078215e564b363fc3007bbece6ebb936de032854360732e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.483-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "85a537d3c43fa14f18ba6cf088f05f302c5ba6449e94ebaac2cbe304fbe823e5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.483-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "21102455495b27da2135a9b27aaf7e8dfce749c84691cd06b03900a4aa7ce7df"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.483-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d5e0d1518583631527270e500d808cfcf52a8a51c672506040a166b74ee211a3"
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
