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
  version "0.5.679-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.679-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "44db1ed09379782366b9206122a2a6ddae63a5ad51da9a76f5884df7b43edb58"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.679-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e8b5ff23570dcd1cb6db02379ce2bb801bf95269442989aa3e15975c1bb7e807"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.679-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e9043e82bc9de8aeb1d592cf00ffcc23d011524f8a5598c92688bd53c5052845"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.679-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "250663019423dd5d1bf284f470ce2220a90855cfc2ed5a212e71bf95da7efa51"
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
