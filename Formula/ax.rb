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
  version "0.5.681-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.681-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ae063d5fe6dd60237bf217bb6b6bcfc9aef6e4b70cf6c9d7938f952e7bb252b9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.681-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ff0eed450ba0843f8f5b690c02eed4d75fc906050201ab511db3f2dc4170b647"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.681-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a2d74adf93612212ed1818ef705b6aa46c058f75208efe3df4e23d8639bc0b3a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.681-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0371e014f5c1f1c3699b801a3c10c808be20f3911d473c719fdf408e381f264f"
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
