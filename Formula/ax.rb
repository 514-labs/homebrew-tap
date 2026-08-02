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
  version "0.5.591-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.591-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "dd903dc9421eb6868b6c9712f817ab477adeb01dfb568752e3a71f7efe90fb64"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.591-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5b1a891bcfc805abe98f14fb478398b7ac13af821f736c6ab3fa36bb9bf73a84"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.591-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "374d1f7b570147e5430939357d7cc6e96e6e89ebdbcdfbbb65ab9e743f9f2d63"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.591-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0ef871e4591a83e433abc4924b8cac75f0ff415bed7340faf5b35de6b989d9c6"
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
