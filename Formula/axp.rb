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
  version "0.5.1019-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1019-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ce80a4bb45bb24f6c6fef1313d81de1189c94e4ff66033fc1c9db2f74a190be4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1019-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "8b332457c71f3477f4e64e1d03ad6d32cd88ca8ec369c4b1fab7e676b4d7d769"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1019-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3d517b0c140cd5b4ceab08258a4d0c67aeff767ae95835633888f9cded71d7fb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1019-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "06a96bd915f2f2d24264fe5bbc15aa916726c537361badf0621fb28efad0a557"
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
