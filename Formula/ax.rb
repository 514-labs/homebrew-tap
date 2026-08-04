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
  version "0.5.636-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.636-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a1028ef7dff979074a94c5da2ccc24ba9724bb3103e497f454d8d6b26057d3fe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.636-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "53edec4c3f94dd45806edb69c14aae3bb5d9a731274d46085cd3bbb157c55c26"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.636-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e6901334cb91471d658c055da255e9a27f6cd801c2728e07afa4f9677ff16568"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.636-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f233df65e99fd2140b9104c92f31209e503eb80235c75d7d501db77368a4d1bd"
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
