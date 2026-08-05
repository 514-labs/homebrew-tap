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
  version "0.5.660-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.660-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7a0904a64826f54a3be3780f6c9237993a2ca399665cd0346d04590d517edc42"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.660-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "099fe13cebed12fe7b40f45ed65cc06f826b946e1ee9842843cd8699e3962bda"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.660-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5d4ec2366d429ee42c6a188032c79d6c956f85315c59d7178ee4811b4eb5c24f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.660-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f820ea6f95c4e1ea86e8c690fbfbd323a327e0d1e56412c824aa7bb333be2a1a"
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
