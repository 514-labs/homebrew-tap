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
  version "0.5.1003-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1003-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0da857fc2e28ff5bfcb83d29c29fdcf753b6f760256913e62d2bed1442666e2d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1003-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e4678d72ba495d966643c2d9538173b2840392efc5594937727a647d5bba7c3b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1003-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4a48151307ddeb78b9bc81911d0af4b6da89dda14f5a40c256f88051ee3ce7ad"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1003-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e6849be95e1dce07dafd4490a50edc791d10e959e7b29aee272b4e6dbca6d33d"
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
