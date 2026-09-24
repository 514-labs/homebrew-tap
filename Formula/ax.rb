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
  version "0.5.1116-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1116-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "af3ae8e44374709ddeb263c5b9db6a2cdf6416c1169a52260df4781d5ccdd2b0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1116-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c373645d8a421bff80ccc435150553e3fc68b967068ce05d4a24551a0712c3a1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1116-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3fc74a9c926b616853b06e50e9a61b1b839450609b0f046129c35e36af6a8583"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1116-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "27dbef69ea49dbba7dd0b8d144482f3063efb85620b3e7f1661f4156b4a8245d"
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
