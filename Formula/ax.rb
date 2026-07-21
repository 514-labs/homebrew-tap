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
  version "0.5.328-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.328-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d26cacb27a59ed1c7dbd87cee7349ce62269bbaa5056e2f6f7289c06008296ba"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.328-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c510bbc54ff23ab72bb38fc63860f1ef7508efef2853c7aa8af8f6ffb5b435c7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.328-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8d48b48eda6cb350f85419ed90ae7f7f6243b24c292d4986bb8334e58d4b94f6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.328-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f06346fac789e4ccdffd29af86d12ab07a0c7268f759a3b660f1c7b2b98e9a34"
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
