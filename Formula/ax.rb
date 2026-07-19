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
  version "0.5.299-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.299-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a5cace8542dfef2efcbcfe366723b3e623cf3aa4fc473ebadf91ef224c1c9d14"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.299-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "41fd6f234cd07187c5d8d47e3a732fba608b08b0f2c54d64ba478499f4025382"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.299-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5dc987b30d2edfc92423d90a865e0cfa7475068c027c69d5298dde3a12ecd486"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.299-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "aa3c9e73ae0dc404ddc4d87dce017c9bec9464020f71c71717ec571d0650bb76"
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
