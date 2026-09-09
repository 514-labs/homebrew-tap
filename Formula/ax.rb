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
  version "0.5.983-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.983-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "812c7459e02996120dbcbda97caec6bbf4d26ee00b1492b1e2ede3f8e55077f9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.983-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fb3842d5546d94b09b6f88fa8682d59e7d0a4b6eb17bdff7a545cdd5bbd0dedc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.983-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "995cab0b06e290f118ac5b7709e2bbfdd4ce631286a31b34aec993db1406ff17"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.983-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dec5e5e050bea8aada1f0d50e5bd4aeabc7cf7228598c15bc4bca8f58cc63a34"
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
