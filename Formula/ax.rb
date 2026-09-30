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
  version "0.5.1186-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1186-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9e56d2ff02a5d12a54de969eb414e4ee5403f00693da0013560fff056efe6e95"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1186-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "98a3e7c5bd85c5bbb87a614ce3736ef5f82070d213b06ac533066262e371cf89"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1186-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "32eb6927941f260517d9cdfcc0f29cfd8dc1a89719b17e9faa9baf3158a5adc3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1186-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a9ae529e414ab47023591d6d7d6b1d3cd71df0cdd3449226892d549ee1efe840"
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
