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
  version "0.5.1128-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1128-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "97cbf2f9fbfbe2bae9c6ab9781b8257db4260e80b90266c89c02c76a128f8b9a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1128-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "20192626891404ecc853dba83ee22693d07ce4c2c5365ae7ebb6b91d80d2cb42"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1128-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c5003aceec3efa165252f645279487da25b1ec80da78205c07fa7bacdb0559a5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1128-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f190fe08ea9c11c9f8cf0d5d3a08d5c77fa4b100632cac247e5091f089a808f3"
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
