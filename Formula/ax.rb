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
  version "0.5.574-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.574-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b3848fa65befd7c7c9bb419018102fe82746f19d7d2227b55c24c9303ee51ad5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.574-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "da0d8e2fe0341c3fde6f7d1a527f15948867b45b91ed55074f34694607028d43"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.574-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bcb5488d16a3fef76e2927ab7ab6fddb35e06fbf14c00304a38e072accac490b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.574-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "baea98eb87e8403f2c9702cadc55033a34827486dbd9cc0cad21c15eded100b0"
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
