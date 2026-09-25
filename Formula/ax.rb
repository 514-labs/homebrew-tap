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
  version "0.5.1134-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1134-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0a3ce904539b4160b37c08153628469a3036c07c2ab15f5ca03d73432d9c1879"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1134-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5ac1806a4056b9900399d26b9291a654be7a0d2981fea0ab595dbd4bb998fe22"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1134-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "075b4aed08e265e8d5f0a224e00c5b2790c1f5d45fb935515e647ae36dfda157"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1134-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e343ab86b9b95661ce82dcbbbe01bffddfe988311ffd3a2d2800bcf8ed1a9938"
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
