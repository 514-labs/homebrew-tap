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
  version "0.5.1120-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1120-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cb6915d6f2ec71ea742e9a86364953da14c92b0755e7e7b64db652865ece3b78"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1120-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8bf97e68ad41931563ed3caeee88da7d116ccdf22e434956f2a2bf2147b513ed"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1120-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e7784324eb39c6aef9e59e699e902fd02501b831bb6e6e9e222a7cf297437c62"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1120-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ee4e2556dd51f9e94ba8713011d54965a02d1b0b33c7a7ab515f43dad05a3583"
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
