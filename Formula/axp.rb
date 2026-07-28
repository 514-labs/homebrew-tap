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
  version "0.5.482-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.482-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "89aa327a77ec6a3d27643d3e6de0392c3c6850b4bf8f616876bec90358f0fa84"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.482-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c18dcc1290cfcade64bd89132fc37ade8b9b1deb586a219ac3c7f81daeff7055"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.482-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f0a23e49753507e05637ab084abbf5c94bbb176843df76c7a14a8d37a5e81c50"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.482-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e49817a571290c9061a32da3d991af9c9dc08d29171614be2f491f9cc8918ea6"
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
