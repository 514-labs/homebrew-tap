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
  version "0.5.833-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.833-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0daa516845a5fb4de5a6e77fe642c2af07e20a1577a5f1e15e594819c83d64e7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.833-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f1d8ad7213ba30995d542f3e2a33cab45e99addffa8eec96da1290325a43bbd0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.833-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4fb324ccaea9a50ec7dec7bc02b8c67017675830bc5dcab6e27a2f4ae765807e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.833-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "538e1d3ac187a6c696837432e10afd1f522430f4f34aec9f26df1ca258c7e28b"
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
