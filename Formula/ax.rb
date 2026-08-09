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
  version "0.5.722-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.722-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bc7a68976a403058b11e4151e4a92ddd5e9fa0f950eb90d88e14cd35b03c1082"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.722-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a86829f125c7c7d222d238179fccb2b36553ad4393cd77de08044473d50209e2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.722-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fdd149d83bb061d2b843bc3fbbcf8a7b45e91ef56f03992c064fd497911f59be"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.722-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5cb2655b1c75a6a574bdcaa674365c58311bc2547b97884cdc976c9602311d35"
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
