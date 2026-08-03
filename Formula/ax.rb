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
  version "0.5.603-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.603-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "21c8abaa25bc3e14a506e19cd0bbd1c7665887814d588be05f44b5845ed9873e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.603-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "264d7d8858764bf35c86b529d5dd23fdb6e9d52eabfc4539ecd956d9b45d46ca"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.603-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "08e99f54fe6985c3c1a9b86476956562269f81bce3c0c92e0c3c27db5dfabf0d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.603-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f4077369e120f986fc82f7d3a177486c0a315e55524fc2490d7488c8d61f552d"
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
