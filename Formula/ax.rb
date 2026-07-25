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
  version "0.5.430-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.430-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c49ac9280115d0283df9954837d8fc0dce4474606b0d5a8fe479260a8cf2fa8e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.430-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "22df6d9aab5b3fa070bd5ac23bc36212b4d570bc8ff5b81c9d61be80f454b091"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.430-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e86a3e012d28b932355d446863bf687faa66e2fa8795235093c274da08854538"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.430-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f73d93646514728c7b0b3ec5362a402b60eb76352ca8c743b17daa7656d52394"
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
