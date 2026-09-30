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
  version "0.5.1209-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1209-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0dee100aa5244ece8f4cd8121ac3eee26fdc6c24e2af0f3b8423e05d11bfdf26"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1209-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "69138c1385b9c823db2efa54bff1b6d3a4b166f24aa7b18ecea7cd92ce781fd4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1209-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "16fdc573bdc2b0a2bc8080aa1f0cfa55ebe6a1bec174b7a7b2a86a08d7ee967c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1209-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7d1c179dd9dfcd9028df0f01b94d44fb9b3485b06ad8004c0f1d296c334a3c57"
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
