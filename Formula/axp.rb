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
  version "0.5.298-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.298-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2d6faaec6520b2cfea506f73e404e50917de3e89a067c414ab4732e109227615"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.298-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "20118720941e04df9f8e13e5b31a56bd2c05afa44cf0f1c8c273e18f0ad0da7a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.298-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "57a08bf1fddb2073d5abf1c38ab53018e076859c9c7ca2a7bed2c4f0862c00b3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.298-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f3a420c779b3770dc06f60cc6e4ef6d2fb5a58c1f88d5f598a1b7971f6c002d1"
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
