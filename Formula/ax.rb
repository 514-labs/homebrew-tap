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
  version "0.5.570-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.570-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "93217bdbb64ed4c917d117f34131a82d7ad29194f5438395f4e4ab38371f14c2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.570-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b2922d8158cdf49ad11249cb7305844d097d714ad083303368ec5bdb343bbd16"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.570-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9f5d3e310fdcb5acb6ee681908bc186ad8e64231c99fe4b43b73fe224babb52f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.570-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "916dcf29051b0fcb117f18f804e9dc315ee60c4b601b0aaebf243abcc0341cbc"
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
