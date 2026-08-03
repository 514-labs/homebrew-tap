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
  version "0.5.604-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.604-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "52b6c23723da3a314fc31bfcab105848315a2c05c511e27e19151632c7bc566c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.604-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "99e357193babe6c6f756605696a583bde93a1866aa1d5b826b4c42e718a05f3c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.604-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2f23956dd222cd722401815b5a0ae4b0a789b8632e99b73b23875b6987823325"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.604-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d5a5d583a5a7452a092d249adc4c434cf236bcd42e8017c4cf970fb9f4c0f79c"
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
