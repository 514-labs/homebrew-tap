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
  version "0.5.1062-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1062-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0bde0d911b73b52f2b8380838e4ae0635cf99ccd81688bbf5f6ec273df156d76"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1062-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b8f991cd6ab86a2ade1d4cd8d3038838cedfd379126cd2953fded95f13d4b35a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1062-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "152c798efb266cb4241a751675c60c6ee2bef0e8c3bd26ac79dfcd34878a581a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1062-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6e81db0fd6e33d1aa6418ffbeec4cf06b00e6df3a325f0b6069651b7b2343980"
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
