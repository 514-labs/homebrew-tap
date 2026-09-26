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
  version "0.5.1147-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1147-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2de4716db7c1b1ad40f651ad2c4b37a48050984495953609d83fb385c4f9196f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1147-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "880e68f89cf0d66717d1e23ff3d30b0a3a8d4ecc1033fa11e6d9c7d900b2182a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1147-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d0bb4062bf36d9168e20cc59c84e6ed96d7a96376b4d66fedde5d5f97574c242"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1147-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6443f63f4409dcec62fdf02382c67eafbfc08da3a43e8316f7aecd8667ea4faa"
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
