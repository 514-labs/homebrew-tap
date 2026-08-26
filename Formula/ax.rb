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
  version "0.5.889-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.889-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "857d04cbf49ccc7b3fd70aa4e8dd4d50b9cbbc1aa4b25bdcb3f80b675924a22c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.889-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "262cd47d09d3bda1e6d8be35a32a90814e86590d794860e921687aef18b807e1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.889-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f48e8cec2ff17deef8f775758c8f87489bb7b25c96f78ba5863e0a5108fc82aa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.889-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e38074e854280ee3a9292c68c77b9f5b585d6c44cf9ab611ae9e3f80bd07cee6"
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
