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
  version "0.5.1112-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1112-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0b7bced50df8a3689bc7ffee4e2726b668e597e2c8bc703ec6fc715d044ee591"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1112-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5fd829892dbdac6603e069cd32c8190941c50aa2b947e58b0369b6d3cf1ff8e3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1112-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3f55a5ad5c02907c05b4efb813f33896065b64dd6b293842e27fe2814df40688"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1112-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d9446fca62b7c0956bf61d858c096dfb5a553de1928f6077d7cbe2bb9eaf26ed"
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
