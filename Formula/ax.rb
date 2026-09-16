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
  version "0.5.1059-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1059-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bad34d43657aaf74cf844fcb696c36e52295f4cb96b6ff6392a3ec2b0b9c892f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1059-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "68bb9ce5ad552a7285710ff57e89039961936c7d494526a9f5a99794067223bc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1059-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2be6e765ff902cfa926bbce102012afc6f2725958936dc9cb66e0288e7cc2f8c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1059-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "462e4d47ec291dfb5c030fef0ab28a2ab3ad97be3feb7fd90465220b4b30696b"
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
