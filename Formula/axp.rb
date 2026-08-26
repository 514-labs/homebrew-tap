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
  version "0.5.883-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.883-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "77593e01b6c4a9aaaddc3a1f6151c171d2fe338666caeae17b20aa52a7758d1c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.883-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "6618f8835fd0fabeaac0035b510d509401b3747490cc2d7e28031965873b3f59"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.883-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "28de4540b928b578702c112b4174a4aec66d752596d8eed8cdb393d699f0e864"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.883-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2fe30416e6c6701f270b2a4351bdd25d56904e8d5d6c4e947e80c759375015ae"
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
