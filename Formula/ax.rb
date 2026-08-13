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
  version "0.5.767-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.767-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3ab15c6eaab0ff66cbcd545703ffb06541debc0acbaa40e97e0764e9a18d81cf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.767-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "131f307aeb0c25f940b8a0085ba964996ca5d7c151fb56d67730304c065ff23c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.767-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "15cdddcf8455ece7277780a5e8f84b131e8af4b19333ea563a5dd827f3a1e7a4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.767-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7d5254ffada75df77c5746c35724a9d728a4ddac8c48bf5694fd3c77c69efecc"
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
