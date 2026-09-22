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
  version "0.5.1085-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1085-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "510f65d5fb91ea22ea9324d72c8f9d7289f29ad99e3bb28fc4d4fe24a7c55cd8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1085-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c04bd098332572c57a307918e2d811722119f4afd5d9051cfb6d6a12745873b3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1085-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1f392c88d06f8dffbb41575682d45d77601188baaf03f6a245c870cd0b2c65b2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1085-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9b79fd4c35162501b8880a91b15102dbf0b8a9b0a06945dc71e5c731cf0d9c39"
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
