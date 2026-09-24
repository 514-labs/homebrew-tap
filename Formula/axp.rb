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
  version "0.5.1111-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1111-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "695ce53c2c90296ccac7f2fa0aee7dea646d1f126b9aeb66dfa01fbe0f271abf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1111-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "500261e9a7f0cca4e1257fe684caf2ccd80411ddc269758e2b1f63bde1178d23"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1111-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "15e4f4da3af3c18889b752eb44d0f6955e7b58de215b6760813d216b193735b8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1111-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "431e4f8b6dcf183853ec7ed1ff7887a4038de1b61333f29682fdaf18fe9734c8"
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
