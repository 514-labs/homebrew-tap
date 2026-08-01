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
  version "0.5.586-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.586-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "07b047ef5e46c3da061ee8cefe90692cb241a75ef2ec33a46d4c6835735aa163"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.586-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2ac0808f0f4c67606d38b4a69a6ca1f37d6dbb57c02f5d033af14a16717ac0e7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.586-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "61c913fb5c957dc3004ce97a020ce36ce59c8caf4338c85e202cd4d3b6607474"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.586-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "707882828cd8e9c26a416fb7929e0f2aff612d5611f42142763e9f1997ead39b"
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
