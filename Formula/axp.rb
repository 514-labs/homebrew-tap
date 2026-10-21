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
  version "0.5.1434-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1434-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0276a5535a9bd019b5ce30c3c77899a3e7daf5e743b8853c73324a52aac12940"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1434-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "522d2706177a59354c36899427ecfe22a9e21c253866ff7ab7cf5d2101b42ac8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1434-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "550f2d193c3fc3798bc72323573e96056763094d596cecb26835f45fa585fe18"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1434-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "dde765781a552b27ebbf856cc80e12ae20c095aa60287bc78f069c1218215564"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`axp.tar.gz`), whose only member is the `axp` executable.
    bin.install "axp"
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
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
