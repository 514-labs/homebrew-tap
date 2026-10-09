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
  version "0.5.1295-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1295-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "581183124b4c45b218f31dee54634f1e873b4a65099a66c9e3b8f1eb10610b84"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1295-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "414116d36dab2af77101af0f121652ed74492a831ebb44e665f02118be4d36df"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1295-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "962e762f7bf47949c5c7700a6354304f1a629f18c98580b3174c1ba3159566a3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1295-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3aa3d55edde897fa30d5364acb955bb06b664d4bbf78be93598f6db03dc209ed"
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
