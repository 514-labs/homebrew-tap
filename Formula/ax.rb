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
  version "0.5.413-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.413-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "67b422250193a78fe677faef6fcd4568b12699638d7990da84fa114f132fefb2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.413-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8b654cb9b0764b4948141c967c04907b249fb98bb1150c2f11e2fda20dc02685"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.413-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4df80751f13f4bd9a19496da3c2fc946d8a8709fb3532bb594d9c71e7fe45ede"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.413-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "84ceb744fb2834533d9446115383360c0791e47f95490c6dcf28d5ba914ade7a"
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
