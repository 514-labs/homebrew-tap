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
  version "0.5.605-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.605-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bfa061b864ab92634b5361c5828b068ac3a02b34f50cac2167b989e917c58a26"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.605-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "62a24ce81c4eda5dad7ef6f5f7594805890fbc6457380807dff02f231fb50d30"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.605-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0226811f10a3349f3e124aa4e18f5474769d297ea2ae2d6c054b9ac0e1651ede"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.605-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a145fb55259b5e70b17171955464c8a8bd0ba4de9fe48f8586000462e1584fb8"
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
