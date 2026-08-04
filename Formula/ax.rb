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
  version "0.5.628-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.628-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "277d346abac809d5ef2e1a01ad1956d92b0a56171250fa2fc0dda42a4d6fea27"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.628-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d3f49ef2a35e5af9d7448c07b9f99cd50fb8141dcb01d2d9296f85600c7c152f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.628-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f9078981b493ea40183c68080b21af2e2a19766a3006161bae05730fe3efe0ed"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.628-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "521ca381ba128b0f2003acf57c6a3fb3de5e0ffc3e052f4949c8c1bd82844bc1"
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
