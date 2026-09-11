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
  version "0.5.1029-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1029-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7f6a221b40931bb53982eb51c21236b4a7298b26dd20b7d55e740b4759aa5ea7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1029-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3f34c7408c689643d78105462973550408086a4fc203399b5c40457d7a1a2d05"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1029-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0635060358a224e1267aa63e03465ce27484f69b1c1227914350f871e0bba054"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1029-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b636ed2b30cd8b16f2292136171a39f4cc266ee9951277351d5a60b69fb63605"
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
