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
  version "0.5.922-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.922-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e570545b735646047f6b5d6dcfdf5ce4f30dc47693719763ea5dd5a37b9c04e3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.922-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "037f0219e2fa408955993fcc6a3b074021f6c5e6bd10555d08266ef0324b8d39"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.922-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "af86983f7f3cfead2e957affa454fd84e331f18e01c3c2d8766530de32476b27"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.922-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8067d648cc485b98f6954875b8a72ef07f3f84b575a5e811e9fd696ac009104e"
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
