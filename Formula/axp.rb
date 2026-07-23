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
  version "0.5.396-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.396-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2e9c524a299c36dd3d7aea40837924686462a2d7be0afefea8ff9a68b5936fd9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.396-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "642f4f024f47ecf7f16a2e11aad1c364c9812db6d3f862b20e4e2f00cded4c85"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.396-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f0d477ca4287960fba78dbde86ff0f034181f6a6f4883dca3f31a2e98289a882"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.396-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5dae599a40f62f9f87bced6bbb92a7b178c2be5e4c97a859e6aa3cc87b88125b"
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
