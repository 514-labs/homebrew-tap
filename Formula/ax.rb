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
  version "0.5.663-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.663-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f097a22828101bf5684e8dde0f7da8d5d4d64ba7ae6722a1e1c643dcebf60b48"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.663-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fbb08ecb85eb179d6422d62892ba3a91d72ac5bf696ae6b3dfca6f2d13f2ad42"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.663-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "da90b26bab016a82b3bba1a53cd6ac7b632229b48f767d8647fa3cd74107a304"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.663-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d83357726f03904ccfbd4e1997a683261d3ac02378d91f0e01123bcb7709dc66"
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
