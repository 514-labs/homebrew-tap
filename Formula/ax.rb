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
  version "0.5.998-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.998-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f937713215d20f999759f5ba197336d4e0916d6dccf584ad89103e498c3f7b54"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.998-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "407afbd86a7e8241e13002f04123e991a81b40d48b5cf84585bf02f51b616ac3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.998-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9ca695a7e55fb31badbc88b19975fdd353d7ae39e5ae1a2c910a0e2e84011180"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.998-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7c94e48a2cd3124f78c63c1ba6ee8eebbc9aee8f942b4a88c3a8e3d8dfc2cb8f"
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
