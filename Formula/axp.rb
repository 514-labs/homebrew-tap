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
  version "0.5.287-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.287-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b189de2681a5f25ee4b857276aace2e53c4da535bc87e6b2731cfacfb771a764"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.287-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "022cf5144e17e0571194c0c63a984f0f32f41c404de56722f868f3423a263804"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.287-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0c78dfd25fb3481e1ca36b8f0724fd15fe52dd4cca89c3b8338a2c6475ba7301"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.287-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ce8f9e72c892725b08ba35b8b2c7f6a1cb58ab3d285b971ebed58e72330b5630"
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
