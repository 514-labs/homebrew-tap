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
  version "0.5.1102-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1102-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "95672f752e585453beda483e167bd2f317554ae0e199861a5b6733d9e877ca64"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1102-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "01ba503ae543c3cc939b9dbf505056365588e42c5e28593a5fc86700d2ed28a5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1102-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dd80578048d6b83bd6f190394f4fcab97cefccdc8c2e4a6a6aead963bc6603d9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1102-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f5f26be68d54fdeb816430af5b8d0f65ed468ef4e1f42d2206be1a4c54899ef4"
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
