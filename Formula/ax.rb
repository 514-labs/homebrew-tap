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
  version "0.5.1070-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1070-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4e2ecf625f4ef88a9ba615528485ac290c9dd08d7cf7f88823e8b71ebba40f0b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1070-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c3b7ed9d4a1bf977919fbdc79251d7744e0e2b803a26e442251e46d48a23c49a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1070-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "53bbce3568dba52afa3dd4ffe63c12dc1c4d0ec2919b94f75db3a5ac66a70573"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1070-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9d047a68673f32d65c2afecfad1d9f76ee272dbe689a4ccde54e43098c876b15"
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
