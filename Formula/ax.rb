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
  version "0.5.556-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.556-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ec03c82f7ee09ea53d1b63f29bc669f5893ebb76d99801a0690cf58dece022b9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.556-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "386c6e0c2ba173ab29d3ab7b6a5c3972b5da7ef48c0e17a77bcda023b0d0c1a5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.556-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e9c0dd8636171f86333ef85ec4f82126bb45d959457a694118642491a803e5e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.556-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "831d0fc8809ed94cb10721a450b859b419a98e19dbaff360e910d8cecab49be3"
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
