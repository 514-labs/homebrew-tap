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
  version "0.5.437-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.437-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a06b13e3cf541e56bcb0ec1deca0fcd1f17cb5f6452bf22d04fcb085357c6efb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.437-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7b53b0892cf31ade5cd9cce962073df7d67462c59e09dd3589225f05194a46e8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.437-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9a352540644e52f0b761e11c56a833e5c0e8dda6eb40257439fd350ed4acd529"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.437-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d24a9dea4513c1c686c5eff554ecf4f7a0bde88deff4d75a1e55d7a4853ba30c"
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
