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
  version "0.5.1006-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1006-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3a5d22a729b320c4a944c56549e45b2c62de3b4310be905eb7c0dd923a37c97d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1006-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "75fafb4584808f9534e0b17e75b2f09eb7b011753553ba16a5ddc11930842d0e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1006-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "516a0fc2d03820567ef47ce1b9a884a436f67e3c8b9b63ff08a9c4252cd015ac"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1006-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "04702a204c2de8c6be6fd698f0eb305d1af3921b2582cec085b96af11cce49d1"
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
