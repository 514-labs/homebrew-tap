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
  version "0.5.288-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.288-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "46edfd6c55722d037365fb128aff9d05285691897ccd00a24b1e50213649b3d2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.288-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "825c44f658b091f2773852a19ec82d0e3985244e04208951e644dbf51a2294da"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.288-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "90ec91ef633305451a430d07708e45300f5ff45d14cbd04ecf087d33325614aa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.288-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "14b4e37e6561ba316c60334e9d8a4f261452e2387c42852f7abed3e2fadb1f54"
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

      Create and run your first experiment:
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
