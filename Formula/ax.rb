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
  version "0.5.738-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.738-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a8786d4438c136106df5a8ccbb37977dcd7af2844d86df31b41a31ba4f509cb2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.738-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0631af384ffa41682a397e36bc5b652088c524b8e90b058bc9936f45c7f12050"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.738-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b9ea014677096217332035d50040f42f464e85509324bd695af68e323de89259"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.738-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ad0fd51597b4f77d9ddd4f19586c3e9e148e933bab9cea7e3ab6426c7ea0c302"
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
