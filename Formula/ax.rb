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
  version "0.5.786-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.786-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f2bef0d2c294017b0c524ed552a23a07fcf5c87d890e3656657a96bf2b548869"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.786-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a13f2b8b6dda09a483f23b430e307971670e997c3bfd73120f1969c9644663b3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.786-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7d9d2d68868ad67f00d99411f70b6545ef5bdbd2e5183b8afc4d995e5a8159d6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.786-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "808af2b4eb472bced274d5bd2d0bed5a32dbf7146893f8c84dc5b2562fc46e22"
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
