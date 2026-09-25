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
  version "0.5.1131-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1131-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8e7abeb58cc1fb4319e4e8088270bec7af4f3dfb0935ce6dab3631ce70522ee2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1131-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3a21c68cb3d22edb308ab31496e77f45eb909d4bc4ba5bd530b33d73b9e4b3b7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1131-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c5c896ad8d7da8f9a9aac33c852f538f949a7b9b504584d96a73ff66d7711ad4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1131-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e39a299eaf1ff5a22e2c14d56404bea75e48057fe6751b4e02c0f86105014cc7"
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
