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
  version "0.5.1037-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1037-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "243be4cdde64e87e4703c307e24d9f067aaab9d5d0f0c1e2ec883d0ddef28ae4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1037-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a1b7aa84f451b0bb0958a0646d28fdd6c47f2ed15bb77dca642c7018af7470c3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1037-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "66fa5f4dcc55de2820c85a3ab2f04f43e4521dfab2b9925b45857c61f4817b14"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1037-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0a933dbcaefddad39a7e990661e67cbf4304463a4acc26a8aea3ffdea96e7052"
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
