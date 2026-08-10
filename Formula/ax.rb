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
  version "0.5.724-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.724-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "55ef9ece47aa37303a0c6af9211a2ad201820a7158f54100ab4add0edcc77af8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.724-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c81c8f2802ebe13e8d74ff69914563c3acd19825b0309ab7b1146652ecd56e19"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.724-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e3f89cd8e67e493a525898beff4d036be6b99bdde11a002cd1662a6539d3e113"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.724-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fd72f81fc35987f4259965f3e0c667d06eec689c84007b0eee1eec1a2337409e"
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
