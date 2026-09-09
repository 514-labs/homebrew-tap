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
  version "0.5.987-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.987-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "212efc07da6a84572c525a049fd6a3e8cf7d0a1aac3ad4a568bdb86e44c52334"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.987-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "32d6481ea4beec519dadfe77e0ec89540c8af17095d7eeb3c48d283c2230d851"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.987-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2cc6d647596a9f6c3157e2ac30f2a634042d8e6734265694d7f45fba6a068b15"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.987-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "478eda38cb1526e76b77af2aad99f39f7be0f68cb87e7680d1b7b24bb7ef28d9"
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
