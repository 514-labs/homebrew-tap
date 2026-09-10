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
  version "0.5.994-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.994-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fe5b1743025f51216dde5523f21b39cfa7d7f2e0b27edd2fefefbfe386cda5d2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.994-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "21eb92f29aa1beaf043ac8307ef77bd3e4eb99f144f7ab7c7a9e873ee74aafda"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.994-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0c3b0ccac76d3cf64421e19140ce558fd619539e5711f636a5e4c437c68fd0ca"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.994-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bf722a11ecf07ca471a4e89328bddf5b94ecaf1decf213779cbe2a5e95961e0d"
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
