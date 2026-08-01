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
  version "0.5.583-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.583-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2d487dde34a2a1ab715206ed15cacc0e71f26de97b43a21ebeb7434345cde2be"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.583-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a7b8cb4e0f1e573db30e2efd05dc5a3bed9d4e70967d0b99902d31db2ce110e9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.583-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9ffc19897d59088e8302068158102db5961749a5108e3d26ada6f74798b9a068"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.583-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "11a89e78d3aea41720a36fb3695780d73acd41d2f9beefacc8f5f1bddd08872e"
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

      Next: walk your first experiment with `ax learn quickstart`

      Already have experiments? `ax experiment list`
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
