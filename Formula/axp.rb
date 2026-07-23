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
  version "0.5.380-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.380-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "61aa5d746a4a4f605b2c8905e76c800a657ac8cb7062bf0ccdfb15b1f5c700a5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.380-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "12dcd86513d5cc65c67ea5cf7d5fe49a4c90bbaaf940c85f4dab498d3dbe2421"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.380-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e6dd4d8634fc33adc288f73c68a8154c0e17d312c1d1ea0961af43fbdb7d627d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.380-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d37823bd26dd58c8749515b0db9fc8173b46bc91f1be9f58cc2234b457e6e91a"
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
