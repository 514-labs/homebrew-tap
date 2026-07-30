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
  version "0.5.541-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.541-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8f06e9d7c872ee82afc092d6ea9ec2c2e2f26af69ef4285cb2883fe0f8fb73ce"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.541-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "46f6270307f72ac480b659c1bd5e010469c609bb0c017bf689d47264b9853c20"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.541-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8b8701e2e7139a994658afa86bf48fd6c5dfb669364af4ce1069db08938b2614"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.541-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ba3cd4ccc2fbd96cf9f99c166eb462eccf7389394807b04b61f91d6baaf167a0"
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
