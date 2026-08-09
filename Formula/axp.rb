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
  version "0.5.722-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.722-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "92bb5c1b9bf9f9edb259be0db5dcdfb6b7edada3e434dd6f188961bfe6c2c198"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.722-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "3e28b1b7488a9db8d8e28526dfcaba52b2aeaabca1b0aeb5f0803516847d5d37"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.722-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "395978d14e68e83f446200c1bce77ef54989fc93b04b1cb72e8293a81e186bd3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.722-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f9ef657f5af9948f0f42a9e2effaf55562766b99bff6c4ba7b85fe0a353937fe"
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
