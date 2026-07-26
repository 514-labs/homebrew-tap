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
  version "0.5.463-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.463-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "49183083ee0b61c30dc133cf50d1118aadd71aff9e2282973cba244280fa4e25"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.463-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "89706a512de64ac9e3911d4d5f84252f7abe32cbd2d3ba6a834f168e91892286"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.463-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "10c244a180916c2a47189fd9095e74855a9b77b4de04b32491ecac90ed0f7b89"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.463-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "94038edf350091402d923d4ed0766bf74b0a396e7d379554c5bb32792aa73386"
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

      Create and run an experiment:
          ax experiment create my-experiment --template cli-install   # your agent writes the YAML from your product description
        → ax experiment validate ./my-experiment.yaml
        → ax experiment run ./my-experiment.yaml                      # smoke: 1 repeat per variant; scale with --repeat 5
        → ax experiment query <exp-id from run output> --metric testPassRate
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
