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
  version "0.5.1180-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1180-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6c3b96a1bf24c74f3dcfba6d26eeaf9148be4a234db347a20f7f4c8f8cf5b82c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1180-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "76c1f9be4a230fde061345522e5701de2938590b8f024086b6f37e0fab33e567"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1180-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9db8ede0ccbc2f3b6794c37875fb6b20e5d3b500fc2f944dddeb459b8ac6298a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1180-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d201712ea45bc250e44e73cc5db8a263deb461d20ca6dd16c4e01122ced007cb"
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
