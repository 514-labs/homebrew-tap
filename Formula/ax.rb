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
  version "0.5.309-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.309-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "80507e78199d80678d7f1fc6446138bd565d38a4ad0937a9cf022634c23363eb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.309-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e9958b3c063636d2b6eb25be3192b96c0e23ea960416925a9a74b54f687f907d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.309-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2f95e8bb6394409c3cf2b7674f99bc751bb2350e3e7664b6f278be8d4cb87d9c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.309-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "635553a9c31836de56ed5f3513cc7f8c81ca71f0bec4d266c9a5278217880751"
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

      Create and run your first experiment:
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
