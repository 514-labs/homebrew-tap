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
  version "0.5.914-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.914-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b8096994b9ce65ed846c5d1a649fa16c44a6bebc4cd4a4e6dc06609211307df6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.914-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4822f90b2f61fb584eaccc91a486820bbb23eae518ad8cdc37434053b0dd9933"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.914-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a1271e30b5a569c6c59ee1845ecc7770f7c9b03f02a66b45865b6af4604fccfa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.914-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e19d556b432481be1663e12d943ea03619cea99cc692b027f55a32b611ee1e50"
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
