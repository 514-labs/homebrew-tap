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
  version "0.5.1355-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1355-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0c5ac9bbfefcc60b510c809c8e58e18637ccd34f4acac710f10c7533efdd6b7c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1355-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e5802ff6ac78164ec9e94aa81e9dbd825a33b57640ae51e785e638bf416ee240"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1355-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "db38bf8afdc08d4fc607eaf544af8cad18c239e736235a46942a6b36ef43e9e4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1355-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "33f2fa0025730ff5b3dbcb32935ceef39407c87f8b74a493622da19e49342616"
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
