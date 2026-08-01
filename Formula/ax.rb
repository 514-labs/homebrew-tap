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
  version "0.5.579-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.579-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ab3eeae68d473e8b71ef96bed0a6245343b0ce7aad7bf875654397f58ee2bb06"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.579-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0496b70116ccdd9ac21479ac7c2ebadd40f79436dd1bebaacdacc5badbb5c70b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.579-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6c9cffec55849bf776da05128297f4f63fb43ecf9c4d8f15a6d264a3b72abfca"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.579-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5311076e22d4015e3459ea97be4869b3afe0465236cbb23f552415e80de335c6"
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
