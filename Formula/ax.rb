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
  version "0.5.709-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.709-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7ccfaa9ce1f8350c055b9bab6c2da90cbb4155f1bde38c1650472eb19e8d6ed6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.709-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "85751355d077d6a1a9810f18a4c082155b36f3ee36e4dc4ea6b67327064f92c6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.709-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "42c4dd5478b53608e3974397327a3942d2b7a77eae7f13b8c41f38aed7c44da6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.709-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b5c9562ce41d794a61eb4471d0aa0a1470d0c7ab9136c097efd3f63969384b85"
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
