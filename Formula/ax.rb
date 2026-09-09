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
  version "0.5.984-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.984-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "dd8a2c06a44cc4d088bf7f471e0c4c71717ad648205d022d1b0fba9ba302d106"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.984-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fdf22bfedc903d770079d2989e9bd602f9a82e9af78b6776cafd418681915ff2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.984-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2bdaf5be0b7862548ee7b3036daf379b9ebe1fcf8716e4a8f813562e7e945768"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.984-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fcadce447507aa0c8631b60d2b92b60bcb17cb87065eee06e74d6019d194805e"
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
