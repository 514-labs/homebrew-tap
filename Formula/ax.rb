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
  version "0.5.887-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.887-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9d37e1e52ccdfbd9e05bbaca77705b586ad59d8daf3cb6a07bbfc8511fc99b7c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.887-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "27cc9c816d0374b54d8611ba15674457d7bdf6238c182d1e7f28a16dd9bd47fc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.887-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8c4877913f9d53f5c6a96416b7c0edfe38619901c5d927d1a03a7f0c0ecc9467"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.887-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "60287ee1f342e440c20754b7bad9d4a27dd271990d2447ac92bd5b47f6a72f67"
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
