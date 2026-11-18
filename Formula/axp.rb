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
  version "0.5.1743-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1743-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "3c9bdf4e73562ce3044c881f751bedae1b8aba34512ac728aac6772edea089c7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1743-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "04addeea18b0975d12a327fa89a43e7ee66dfb4d684638e96ca9108399a9d0c4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1743-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "671d010d697be1e449388ba2335482544f5860a9d63df9ea8352eaba590650e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1743-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d335792f6350f56fe5bc2daf0d008160f9aa21e7b53ed13bfbe5b606201322b3"
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
