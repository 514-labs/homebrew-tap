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
  version "0.5.1049-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1049-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "993fa41c5ae1b82b7e83bda716ad3bba3966738b414e7e9ee27ce4cd8f5ecf69"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1049-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f5863f838ec7f02cf061ac5f826bceec5f474882a1f0a5956c6611e7917a6f67"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1049-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "01861f26145c314655aeba3270280e3aa0e6af1af6fae580fd77e90ae7194758"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1049-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "674ea34440adab6be8dc264f94d9083b2a3b5608f6be77a6d1cf8e70586667fb"
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
