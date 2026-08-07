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
  version "0.5.690-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.690-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5c5245623b3d73b1d4242ad6f81e1e05b8c7ae538c985dc1e661844d9bf5a5a0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.690-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "07605fb290f9550cd16a4264034f44324e8a3e7353bc0902a1ae48d9912a7a0f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.690-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "60a9e817ca020a70c1449b9a9a03b6d8d2cb9fb5fbdda7ae9a71ece9c1c31a6f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.690-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9d1a63d59ec660635ef61b93f66487d0d643c8938e114efbfee8aa4b5d75f086"
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
