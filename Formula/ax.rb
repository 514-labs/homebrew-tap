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
  version "0.5.1197-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1197-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3ff577e2d26f58569046b828e954e8e23e5c9929c29b2a60d686e164bedd9a1b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1197-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6226fdefd72721217b59de92fbf720013ee93412863340a944e18cf95d3662e8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1197-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fa9b1695e5df0b8814321db4828db9eb51fe8505700e98feda125f3d708d12f4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1197-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "06e6be839f96b7f78490b2a2361352597498f2f60da74488fc8d1a4586ede804"
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
