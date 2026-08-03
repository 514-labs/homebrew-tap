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
  version "0.5.615-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.615-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8b04dde59e3d70b01814f4ebbfba6dea2d7c71d698046ab0806fb11d06088357"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.615-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "dff4cd8409087a6b1e2a6a78a341cabcc46865e72b13e00934de88c20788268d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.615-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "552f19883876f1c82b3074d1b7dcee276c979fe0fe9cd6c05c159cba5e7f1c99"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.615-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "453c56d8148125d441b81613156f928020aeae561874d48baa71a982b42f14bd"
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
