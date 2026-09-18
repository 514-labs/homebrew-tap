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
  version "0.5.1072-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1072-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "87ed3ebb33beeeaa1357890cf7364eff8db426f64fb79154e42ccf9ab877281c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1072-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c7cf0aefc2e6958b16d6a03a619ffecda5dbe408d7603584d31783b05aa7ed7f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1072-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "aedd6019bc8d99d4f442349bde2f412dc395b321164e2a4aba2fb2efccc067ee"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1072-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4b55b81d6f587eccf711ca2e8d57c1e4bd46671909aeac793112af28a18ba4e4"
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
