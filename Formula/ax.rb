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
  version "0.5.554-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.554-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "42938b869a0cf8dbc17cc4cacc5a44d49868373ec7fc615d8e40f6ef5065a3db"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.554-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "abc6cb56e8ea16630c6f71816788e9b357582e032d1e92afb7678055f01d611d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.554-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ec09cf92dddd862eea001c72926d6542c1a83dac7c9a9c503d3d7750c6d6787c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.554-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2c8a57173dae7e8a7af7ec19542b1479d5ab7698bfa358dbded7e93fad483a19"
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
