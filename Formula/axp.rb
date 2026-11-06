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
  version "0.5.1670-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1670-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e1f80107881dc21e7a791880e525dd5e9b58c8e940230962dcea748e2b38ef07"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1670-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "17489d43383ff502baf6e2a7a28e77f08089d81e44573105874b9c8bc9f8532c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1670-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d5dbb8ce44e82dbe6f870d491d005e4dd21eb16b867515d379f186f88ea00354"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1670-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6174eeb1192a5aa31083a356824f76d5f1c5849fb11be410a2191c0727b5efc9"
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
