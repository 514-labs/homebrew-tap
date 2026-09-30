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
  version "0.5.1199-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1199-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ad5ea298745c39c3bf1c77947e0ce433a73d58c457cf06e3ac355b4a973f7e20"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1199-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ee29904386efde40db7659dc72c4df565a32d7aac3e469f1594dfe96c55befc9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1199-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "67ce2896d7e60e8c49f95556ec32e5f0ffdcfb23d94f8ea2422138dc6cea5ed5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1199-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d5ebfaba7c80c2d8e093ea7fa8bcddad270f69457c2c034ef362657a4c495c13"
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
