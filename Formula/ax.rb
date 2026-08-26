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
  version "0.5.877-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.877-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3a29607f4ff637759489c5f85716819f973b3214097a9d2cf43a04dd1f26cab9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.877-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4b6f9a5b3afec6457e93dcadf7d162e7b7923f2f0663c93edcf3d9410c6a1679"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.877-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a661dbb7334dfa044f39b0391db8322fee81acb97005214591db5ceb01e8f810"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.877-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0f420f191ed2c28bc829641647e8cf6eb689ad3347138ac7ba21d49ae8debae7"
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

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
      Already have experiments? `ax experiment list`
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
