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
  version "0.5.742-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.742-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e7171a55bd2909aacab3543a4cc3cb8558b116c8e2dc3a0e4d96cc9502b7a30c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.742-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "08637e56c1fc6b836d69a6397b91c7caec13486f21d928df7d4264a80d5b9fd4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.742-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d62f86c4a5997f99a9b2efefb20b0340a025a809a9f483c4b9890b22669aac7d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.742-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "967ed4d54c66af17ba3227df710791b27dd25404526b498b95bed6bcc68a8098"
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
