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
  version "0.5.619-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.619-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "dcb34e110c10108a8a70014c14ca2b1910d1ac8a242d4f61433123716d42732b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.619-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "00aa5c18c890746cea7f2ede006bbb01f0f387e8259faac9327fe3f48ac64ffe"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.619-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9297ddf6d7cc07cfaf4df34477df9f6725098cc7af8dcecd1f6f955803b3f966"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.619-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b0e3800cd0b13cc1f3f242b7aa8e887ebf561833f116be88e1cd94a41fc4f1b0"
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

      Next: walk your first experiment with `ax learn quickstart`

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
