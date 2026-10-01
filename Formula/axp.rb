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
  version "0.5.1221-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1221-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "104f99026f017ac475470cf8c301fe853bec3c30f79983a75352212889e46c91"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1221-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9243070dfaea54a33b9d990cbddd8d1433a14c1f883a23fcbced934235c80f35"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1221-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d225bc5fc24493fe86ac388db2fb405d0ca651ae58248c1945fe5a74d1dc31e0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1221-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "740b463bae262e345edc165783eb5c7f03dc188f9ae38a0ea18fdb96bb1809a6"
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
