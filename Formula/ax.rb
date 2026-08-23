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
  version "0.5.854-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.854-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c23bf558f553571e5ab68124753e26965dc4e518e7b627bfd7f6a5fc6ac8e988"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.854-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "506a8164ef1b2fa080390c516564222f0f75d2ed64cd2a6fdfed54201e0887a7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.854-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bb6d2a4817edc2f4a07907c9ce8bd502f84888f5e3cdb8b2279b4b0518bba021"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.854-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ba04b9efea24e0ab935839f753d930189ca685078d3b5f4fdbed52ef6569e34b"
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
