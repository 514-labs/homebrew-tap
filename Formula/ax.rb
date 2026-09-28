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
  version "0.5.1160-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1160-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "91612e3372bfd93c41fef83b439877881e95e06f007ba1c6871701f876258e70"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1160-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6b42ebe101f9d5b65d7fb2f09a651fc7b5beb82eb8f4e7f0b69b4853742748ef"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1160-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e7768c3e7c89aa506b73ee9b797512233459a67703702f6f5283324e644a9e6e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1160-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3617744d457016282ceade4ab4df47773f4821700510f3822a4604fb6f96fcb7"
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
