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
  version "0.5.989-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.989-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8c37c89c03f2e3a82d576e2a857e44d5d3eae0af9f9f7aac74256161d9d24acf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.989-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f6f602e779b36f0c624d2f4ed73a3cb85b8181a1b42e78ddd562995f620d7b50"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.989-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9ff071faa145a52eb22e88ed5cf3df549c801fb939cdb8a5db680daf9d640d71"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.989-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d1cc747f05d6a0978adf0e0a1e0d7cb370e2941ba45c76e9863828841101ade4"
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
