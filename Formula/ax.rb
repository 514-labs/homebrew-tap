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
  version "0.5.956-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.956-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "42153fc8e9d641a5a6f9839f31e9d394840821dc85ab05a7c6c551e835e1b996"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.956-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "cc3c87c77b8c52d71cbeb427cf009df5da81c1843c743ab29186cd8e4ae04d15"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.956-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "69167e9bdef6258a7accb99575821e8fc2e9f00595112e294b19390153514d02"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.956-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8f3e07778828ef0fae3efb0a59a0b9655a6c7c429bceca37ae38fce7524c434b"
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
