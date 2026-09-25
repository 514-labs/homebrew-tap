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
  version "0.5.1134-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1134-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a06ffd6d7b88dbddb244f26da2f38f1f917edbf40bd6ee6b187fc230372dc083"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1134-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1cf32a2046b9d2af9b7040730f9f8a6ce86cf293f47212d4730a48e52fd9742e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1134-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0eafa446bffdd5163f32c03e2bc1fd5b00f24dca72062b3d38aebca19be10c2b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1134-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a9f22c4a4bdb773a43661c69137475f3d5ac9b29f158ae16ff2d4d231acc9a6a"
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
