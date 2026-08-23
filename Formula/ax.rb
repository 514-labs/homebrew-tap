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
  version "0.5.857-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.857-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a52a8c4a0ae6c5283c19f6c8aa33da5b97ea66251b0b0da34872b96535e3f0ca"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.857-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "59ad783067d258355e1ed0538c97e5dbe03e9f539f0b58ef225372bb600786e4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.857-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5ab84a7b3301c4d76628f1ad38a2af5ad956c613fc6b54139481dfa8bc2f4931"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.857-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f1db213d4651bb52ac74432fe907dc311bd09035d13a99b9cd532a1eb0fcf9c6"
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
