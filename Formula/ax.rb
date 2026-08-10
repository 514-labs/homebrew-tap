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
  version "0.5.729-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.729-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "20e184ee95256e5167bc6038cb777d864ac704e87288ca273521167db1a41b06"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.729-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c6140788ab12c45294e92cc60ca41918b827861095b5298c2d853cd5b94a82b7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.729-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "403bd8e2de56fad5c86d0c61f8493d1759d10b58a7727acbb72fe0d0bd6dbcd0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.729-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6f423fbb0c3ef90e1f746c939a035e6a03186c9211d91925e7ef72e338c0c42a"
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
