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
  version "0.5.882-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.882-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e940e0cca2fe0a0b429bc17575b0680e059d9b18ff9a818468b3ca83a44f8ac3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.882-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1e1e5d88f82916c99e31cd0329d5d0a4a44579d93afaaf52811c3d06d053972c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.882-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "340a2f32130dab3339dabc1a5e1046b3a1b72f479d1936c0b1472e12b4db58e5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.882-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "48f17c29b7cbf060c5f3484414570ab9561b20adcb6ccf98c926912294039379"
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

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
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
