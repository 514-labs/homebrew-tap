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
  version "0.5.665-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.665-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c02c33cf7a3d58582ed6cf1bcbf569cc0333f4557ef6ff3f2080d36a0ee9d7b0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.665-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4baa612a51285fa5967f7439069f94b4647f2857bc118a5e807090aa88834f21"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.665-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e4c0c09c4a332646f0b89db18b75bd713542b189c54e1b61bfd2dbe8f7540275"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.665-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "96f1ef1d73cad87754bc1f78eced797055dbf11e71da8fb9789de9d34972cbfc"
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
