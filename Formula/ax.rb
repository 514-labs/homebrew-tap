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
  version "0.5.1163-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1163-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "802dd078480031535e213b1bc59490e8b7dcbfd3f4816e9f006d3020884e2ac1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1163-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7d7cea3441be1f47fd3cc79ef90e36fbc407b18b6617fa51bf322b8faa8d7033"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1163-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "45e19c098ddb0183154829a00e44b8522239b4ca44e96c5c66bcf1da56bf6ae5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1163-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d61d18dcea69d10b215bb033a2f169f1ed03cb2f9ed16771d8772c3bf1069793"
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
