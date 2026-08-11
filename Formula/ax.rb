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
  version "0.5.740-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.740-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f993fa487061c58f5d078531fff1737e81625c372553579758fe90e0299b1677"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.740-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1d93aa29291ecdf86d6e1f11a9f895016e5a4b6e0fe868d19e34fdd1c43ae01f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.740-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "61575844939417ba16189b17eb996550b210ef053b0a51eed095e265e4d57747"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.740-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7dd8c4848d138351845efed5a68d3825c6880bbf43c0a44cf1e40b5a32f4220e"
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
