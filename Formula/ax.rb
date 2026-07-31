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
  version "0.5.562-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.562-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "70e792ff74f0b08d587de2ab739199adf5d564afe891e53c0b99bc8ddcc09f51"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.562-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "929fdb47327c76ca257d652f705b85aa6155aba31ef806a082678b96ae3d0331"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.562-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a7037b907bd8fa5642a3af62eca796ed637653595d02dcb91fc1ebd7c0af8946"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.562-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "66a31d510ce9e5bae3e2b7a9979787a191e67a537883d883711b232a03f99525"
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
