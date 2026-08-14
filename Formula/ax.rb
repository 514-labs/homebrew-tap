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
  version "0.5.791-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.791-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fa2e93172629fe4f59d74c3778beabbd5a4d7f0baad04b8d611950ca9aa560fa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.791-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c677b91ed2042eeee3bde23968116c30d90246c85687418fe977562da66690b7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.791-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ceac56cb0db2e30b1968593d0ed8cd82a8f0ed6d80a5952d58de2ca5fd1d16fb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.791-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "39ad0408d74600382718977e68718699c1dafeae0c98a19f35b1811b969f8a4b"
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
