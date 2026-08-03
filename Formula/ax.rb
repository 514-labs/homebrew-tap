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
  version "0.5.617-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.617-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "60001970d3ca55a6a9871362e7a51d377bb3c7ab916ec9f37d98451452a93921"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.617-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c4a9674fdfe33b4dac34c46656895b2da718e2ade5b46880334338b3393de0ec"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.617-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c5ef3cc93e8e0d181c3a37dd29d624da2749d20e597194d2ed3f83b428fdf0ea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.617-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "00209208de9817c8530b03caac3af6a76d3465d516fb0ed56842be5d8dbb3be7"
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
