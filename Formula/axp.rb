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
  version "0.5.513-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.513-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2f1b559442aadca8900313741641cdd203fab7a1ed4a95006f45b6bfc644d180"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.513-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "13c01e3a245d316b586f9ad8777f282245c538920996d680ae649f7e1a726ae9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.513-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "04690404cb64d0ffd6be2c19b13409ee34e3ba31acb434e4f28d6b151cd6d933"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.513-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1d7a0c7297fe346cc348fb83a58a42bd62220de2cbb2d9a4af99e64d25393ee9"
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
