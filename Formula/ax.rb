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
  version "0.5.580-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.580-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "69af759742dfab5da328e92e8c6e7edba1a612a05e8d32831e0a7f13863f843d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.580-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e9c4e3e7c4488fff70a969a8b61a16515ab539d6628458bd78de9c462b8dfdf0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.580-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "aab6b8b29f3f119493a38f60afd586bf80669f34a90dce92c74c3751e9960591"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.580-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f803e09d1b94b0c5ef048e1a09e218915a7ebe875cac087dbcd18ae40c863cb4"
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
