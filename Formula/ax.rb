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
  version "0.5.613-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.613-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1d54e07e74b19732c0944614e1658091d6f1677d2cc0d4528f1d712e18196336"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.613-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3077b4575d05d70868e1336c513cf908cce9820a32e72e4e35c9c991f01412b9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.613-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1381dba3765eb354fc08c2b98402d4714cea9e6a114e87e3cbc9d63dae306dda"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.613-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cebd70dc6bcd63dac3a9124d08c65406040a7050e81e08637e924fb5be963815"
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
