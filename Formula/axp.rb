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
  version "0.5.1009-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1009-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e1139cd3a564e38353e2b44aa249df8e1d55d24eafb47c9776239817341befea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1009-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d8950ae55cce900402965e7ad7615d15a4cb7347f249c2ee63340477152a0a13"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1009-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b3d67a6fa4dda3a1c0f4ee2d43167da83ba3440e22b5ee3d2057251577e8d328"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1009-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "784b2f89a623e9b90ddc82d8e1beb919b9fbb47e6e54731d12cc32af0782a643"
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
