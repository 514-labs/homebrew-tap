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
  version "0.5.404-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.404-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4798f4963845716dd07847c58ed9aea10022b9b7de99b68949c18b78ced92720"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.404-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1e02eee93ef478e6858362541ddef2671f998e36ae75aea6a732965da5966cf8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.404-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0e833485dc0262838762e45ce0428c9ef0c795e589de6d65e1dcc73d9aa66a0c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.404-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f2dcaaa5c899481c51db0391c5f36182329fd8f4ce88038e52ae9c6f7fb89dff"
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
