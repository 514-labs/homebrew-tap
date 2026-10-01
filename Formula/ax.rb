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
  version "0.5.1216-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1216-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ee5be2c7c227e44a52349bc9514932db8ab64c7de7ea00917ccb551327799d36"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1216-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d9d1983890b10c366d3e43266743f7abd2e3bda3783db2ac7a7c30550aae8935"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1216-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "87f1a05c511a4b92c56a2f623e946db232eee4ef59866cfe4e37538527840272"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1216-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6bea063e62a69b03bf5b2a36c60d9fa6a9a072f1e4cd26f9eefd94e6c96b274f"
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
