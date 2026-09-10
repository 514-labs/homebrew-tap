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
  version "0.5.1001-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1001-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "57b43694f8243801ff29fa94ce000f59f078cf07e32a21947611e6a91d76ef91"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1001-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2168fed12eadc26c00e89878982b7164da9c57b6ae40ef224277cab1f8164f39"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1001-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "48db5d544c6f4029e77102be1a1f0c58cf415b3e4d52666c3b16c2b91f96fead"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1001-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "09ab1463863e393fcdd0f4c0a91c301688e8b65e43689c0d85ab6700a9a82ed6"
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
