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
  version "0.5.582-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.582-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f8ae3b52156cdf9ca201eb36143dd6e602a59f4314b4cb24e37ff89bd689b5a7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.582-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "78bbacbee7634c2f955ef8639e1e20a79866fba63c31f4d40e44dbb52760cccc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.582-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9cc3e0fcff5693c1d821b72ed8aaa8916bea1ebf1fd20aa20ae6fc0fc96118eb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.582-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "28f30124cf309c90ddd60bc1e36ae5231f3ce3bae4ed649b2e8f92d86f4633b9"
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

      Next: walk your first experiment with `ax learn quickstart`

      Already have experiments? `ax experiment list`
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
