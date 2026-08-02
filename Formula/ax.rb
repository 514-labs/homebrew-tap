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
  version "0.5.595-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.595-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2fa53bedae3d0f45cd19054baa60f4d37629a4d1a7e632ef8c1bdfc2e1d59a27"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.595-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0556e45689febe5803ca210cee719aaa2ee866f97e3f3a92b6c2e98bf2bc0a15"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.595-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "71163dabf870eea51c7a10d630fa672659613ef871e2db044352478d315204bd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.595-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "38ab2708c35baa1236a6f76a61cecf3807c561646bc6d378968989923ac6e056"
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
