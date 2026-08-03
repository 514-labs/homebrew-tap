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
  version "0.5.610-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.610-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c76d83ad748ff413c6ab3cfa17e54cf95fd24960a9c2e30f447c78a2ff9b2764"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.610-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e0e7e034b6c8471781a38a8c7547d14f20464fdab2afcaa3b8d334cf6618e4a7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.610-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0c0ced720d0597a7d6ebc16334d3d3d05a40d6275962a100e79d375cdcc4a725"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.610-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0d1af2638c6957e378032e52f81c85642927c3322b9c746d85b8a5925b6791dc"
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

      Next: walk your first experiment with `ax learn quickstart`

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
