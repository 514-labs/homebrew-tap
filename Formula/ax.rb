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
  version "0.5.1189-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1189-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "484ba067758a5c3cdaac603745ffc7725dfa34b3332fae2be36aebb689488c44"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1189-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "66287bdfa8eaa1dac704b2ae219e8da6b9e542c5a5cef961b6f9b8f39ce3edf3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1189-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5280db961beb46dd8f6986e37a4a51760cd714439ac387049e4db076c62e077f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1189-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "216e5c655f25b9ee685748a8d666e5770c82b6bc6c5a53f0e69e355c05810f45"
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
