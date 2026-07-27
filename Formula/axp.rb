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
  version "0.5.474-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.474-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6faa6f16a4ce5c0de8372bd5b489ab4ce49cbf4137db9a4dcf90d28f3474f9e1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.474-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2a5470cbd274a782dde85f9806ae66664dd2cdaa388c98ece45ab7ca61a76815"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.474-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c441e1b24d7a408f2d79701d67cce3390a8893d344838ce9255377c7f93f4fba"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.474-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "59169aa002b137a9866e02457a23a8e4a4b2a462b2fac371bde5eac6be434cd7"
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

      Create and run an experiment:
          ax experiment create my-experiment --template cli-install   # your agent writes the YAML from your product description
        → ax experiment validate ./my-experiment.yaml
        → ax experiment run ./my-experiment.yaml                      # smoke: 1 repeat per variant; scale with --repeat 5
        → ax experiment query <exp-id from run output> --metric testPassRate
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
