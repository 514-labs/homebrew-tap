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
  version "0.5.1097-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1097-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4a24a22c2766aedbfff7b3581a41691fe8da30e17991bcab7d8f2e047695dd43"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1097-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a3fcd899efbc84b9610cd15cde388fcac0de7a33b61ef4ff803863020cb85489"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1097-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d6fa0e3870f08d407cd72b343f5a042887300e74219cfd5be98b4fd16bf01402"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1097-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "16289e1e55fc125225bc7bfc8f26d5250fd63e6235aaa5151714063786923c22"
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
