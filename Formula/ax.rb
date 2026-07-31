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
  version "0.5.561-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.561-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7499854008c53c97e09d4cc1173d14a69326e4bf89884a3e5cbbb60763682936"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.561-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "13971de89145d1035b41316e29f2327702ec27ba3d2082c8c5686f010c561b7d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.561-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cffa20dbba3a113d421a89892577e7b80603201f37860768b35795bb05f81811"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.561-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e66ca600f8563e0f947250673e43d12e8b36088a9f3e56215ee2bc8a9a203a3a"
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
