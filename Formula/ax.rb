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
  version "0.5.1178-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1178-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "15f9052393b65fc371f7154ec71683c31169c13a81bcd3a963e82a4e3ab9954b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1178-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "51d7a6d843f2bda512b2ace7e7de6af2303880037d07f6592f35a990c117c6e9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1178-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "41b312626e058f9355aec46ee4a2dc01abe38290904dfba571936e7602670577"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1178-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7bae8789086462aadde9becdffa11f74ed5e8484dbeb7ddfc667ac2133c4b8df"
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
