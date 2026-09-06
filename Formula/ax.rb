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
  version "0.5.962-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.962-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2ae75024ff69e774815ce995952218d1886f14b40664da9868aa1453425aa08b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.962-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "434c4078ad3ee6fa66a8ef2180c44a9696f66eabab77a3e482d6ac58d18ba106"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.962-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e51ed5ee204a2c23559537dcfbb2af92e937922b9775d2d8c1b313c1ca4416ea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.962-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "21c788d23ca1b6c949a9639eed1e77d496c6e7d8fe0b7db00b66474ad06e1eb5"
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
