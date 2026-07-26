# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.457-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.457-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "04a08c8f4f2dec9f8f16c6a57a635602f9f1d10a20f899a246bd63c6d2151681"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.457-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f341e2eaadcc927defc0f43fea0424fdf5bf3eb6ca6975149d8b9fb78721c3c0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.457-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bc9eafcee4634da23b86e39697fbf9a9b7428c16a255c9aef3dcd74495c6029c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.457-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a27711d96ecc62349c9dfa7bd68788018ac1cbef3cbccc0e86440221aa726b68"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`ax.tar.gz` = `ax` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
