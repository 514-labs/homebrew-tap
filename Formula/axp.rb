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
  version "0.5.985-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.985-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e04fe4f6e52d1e89366e86ed2fad4be12b020243271f2779976efc870dd58140"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.985-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "66c6c8e53fe09ecde6fe7d848b9e2ec5a7a10a64f4746b6d558b0acd55904b26"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.985-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3651ab517cbe997659972512c82ddc02e0cd8d0a45dc8b970f0c20ac273aeda2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.985-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7e523d27fc77f619843f8771fb2f1de3f3cb03489abcbd4d7b553ce5305daf47"
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
