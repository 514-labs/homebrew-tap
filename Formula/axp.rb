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
  version "0.5.1225-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1225-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "87d42026161f605cbca5f5f8ade1c0a8e2191be1bb5467e57655f74a5ba29390"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1225-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "050e2988733bf148a45d65533500ca3cb2bdc37a10fa949fe2cd6f5a12e5dda4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1225-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d104098e3590c1619e14a46b1852359b16f4d421024b68bcdcfb4646e1d8e50e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1225-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "935c634493d1da744cff7f470afd0afd211d126f408763745fbb491dec64d01a"
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
