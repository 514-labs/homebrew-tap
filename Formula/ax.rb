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
  version "0.5.804-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.804-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d9f9fcbc99a3b960fea5353a0b037f1ee837b5761bc16a1d3c5a35b718cb7e1b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.804-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a91a16bfa868e42107d89ac26b385b2ed55a520d1df0d3cbc052266fe1bc476c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.804-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "37ba53f982133deed02c1e248cec37b41a66bf4bd62f2054046bcfe1dc425a97"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.804-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "02d31ecaa892c0b514ae9db11fe02df7abdc8d888c11e49ab3a03f0d1e896692"
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
