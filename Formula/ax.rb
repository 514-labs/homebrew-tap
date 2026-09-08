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
  version "0.5.967-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.967-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7b0726cf714175db430e9e2fdb0ef4d7c0e07003da1ab1707a2269d6497e111d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.967-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f6faab4bd148f24547a019264409b5c8ad3e1395580ae4200ac13e170ce4647c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.967-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bb726c98849a8a7f3a01332dc9d80acb59f2f677f486d698b0e8726451a23aa9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.967-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "871b1f9ced6b3f9caa559568bcdd37f75c8df286f44a4247a7f00aacd2ce43c3"
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
