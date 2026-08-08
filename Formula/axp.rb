# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.719-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.719-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "3550ec0fe75e756ab124886160508f96181c292cc70a32ea3a5d31d3286564a6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.719-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "049b82a9c29336a36d4afe6be6c0923c6dc01efbffd8498830adf56b65e161f8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.719-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9381ab3f105c1975c36697ed4983d210b79c0aeeb1d4b95f97271aace3fe4f37"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.719-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4c4d175e32055bbda650e2f0f2ce05652e8d3cdb5e7b454c5882590745b71c60"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
