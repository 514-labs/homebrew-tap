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
  version "0.5.345-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.345-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fe6dd2ef13ac16a956e7a4faa9de7d5c1a747d1d8b7f7bc4e511521efe07e6c1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.345-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a96d2adf7b3a82a76ef573fb10a39b85f52e15a10c1c6cf32e45d9852a9480a4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.345-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "eae673855fc09edbf70dbe221b87a00a7371992c4c48d9b6bc4fc210f098b54c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.345-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a9c97d28fdd1e544e987d30d5e38b441d241652e566f2f5bde3b233a5b6ec637"
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
