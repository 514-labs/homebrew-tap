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
  version "0.5.746-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.746-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bebc62ba20025dba5c1ca590b9f6368c03bc11a4ade2a6c7b6c8857b2a90cd43"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.746-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5f280d2d3804bdaed0c03ec77d075117618cbb24a7251938b1d81af916f58042"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.746-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c27d51bc16f4c8749400f266afd2e133504bf5fb27f683826db2e431a05bb544"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.746-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8d91c9b1a2cbdc2b7f2559f18c574c553eb1cbd9932adf1d96e1076502f29c57"
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
