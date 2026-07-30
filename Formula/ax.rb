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
  version "0.5.555-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.555-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a716d5982bce17ec80a70f65a43db1e4c5ab362f408e8e65c8d71eba07cf8c46"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.555-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d72e4135168158d2df77a795036352379dd3a9b8bb7a99da4fbf17e69d06a3a9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.555-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0da42186ff3f36477efeecb9c15c8f61bea8d2f342483d87b736feb20160f722"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.555-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "106651d66bfcc8379c28c920bccc73c75cb69f8daa705f95454b591722fd76a5"
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
