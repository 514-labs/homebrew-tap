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
  version "0.5.763-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.763-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "acc874c5d87b26654ca1052acda1e4d13c4c6e9e86202e6e5628be3131672bb7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.763-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8b536331dd2e32b5e0c8a7ebee135a2dd94c2567f7ae71c71200bd336da438d3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.763-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "339437046c0852a562745e4bfd7d89f3b8c871c38ae2780299c9804bcd88ebf8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.763-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "86e3551b3635b89e70ad2c74cf2e72764f732dba144121ffbf89186a9dd034c8"
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
