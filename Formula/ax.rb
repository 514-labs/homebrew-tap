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
  version "0.5.1157-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1157-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b1461531ee7f856e9d9aa1387cfde70529c43d9c09e1e9076894c844e0c2824c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1157-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6cf7299a5ec4ebd78dfce0bb5a98878602151c8726ab3b0aa141ac294579eae1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1157-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c80f69386cb6bc47c82edc0ed2d2124df89f5fd8c6a5f0b7efa909590de73f55"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1157-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1656b5085db71fba02db1472d69386f8116d0eb9a43de0b5fc933957afc51818"
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
