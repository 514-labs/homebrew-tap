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
  version "0.5.602-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.602-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e813bdb4c14b49c714064a083626cb580fb2546abb3717d748d11e72703e0d88"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.602-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "39d8a7a7bacfdc00f3f38a688a1969c7608c73420e96735abdc6ed1bb02ce548"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.602-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "25aee40d1a1845ec5f2b96460932ae34e0afad50ef64031f5c8c99693ea2653e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.602-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b974cd008282fb0c547c32bb7b7fe3c12736dfde25666c2e416bbcc8f8359efd"
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
