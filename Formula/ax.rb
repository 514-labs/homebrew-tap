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
  version "0.5.1039-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1039-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3b2139b515aadc7e6408ae35ffa822bc1f398817f9f9dbea516b6af23ba0f46b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1039-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c7d74b399bf6d664430f516288e821c7bb6535e94ead7971ec06c5c340bd8526"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1039-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "457b0703d933c9072d8747f277b063d27466452b2d189c7da70cef3268220158"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1039-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e802dd3435e596a08c39ed4064a15759cce7ce6f2f0220e6ad9e8496c05dc523"
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

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
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
