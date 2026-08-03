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
  version "0.5.611-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.611-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "53288973519ff227de9aca078b9883ecb83b0a76bfc0a40f658bc152e3040930"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.611-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "28d290241b4c17713258211c0dba9d81bb02830dacad7ca5b3dafded174a81ad"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.611-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c985df64fed9ab941c53fa892d43af370502081418d7aa2163d0fce7cebcdcd4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.611-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "be7120da5f7d3f3388631545cc47bcadfdddbe69308fdebaf7e4c20baed54732"
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
