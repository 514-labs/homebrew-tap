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
  version "0.5.458-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.458-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5267229f206d7228a35efa798f194cc53d1bdfa564d651a084bf07de9c22c421"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.458-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "87e09620b0a3d1d97f312582354ba4c985673598f54b04c383af57ce51fbc07a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.458-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "245af95a90be8934db1cdd84c20d22c70d3091b8f786c7717a384be32bb6cc54"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.458-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "87330d11cd4d4ca8a8d2bf878564a7e19b1a221a59bfa58400aaa6451b3919b3"
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
