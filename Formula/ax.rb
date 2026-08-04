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
  version "0.5.644-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.644-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4bb63e855e88983b5965da8b23a9d63c5a5082d2766edbb57cea5c24ab47f59c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.644-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "174e45f4c38cdfb65db00656e9a01273ae716f7ec4707e315b512f0db6e55324"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.644-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5b793887c5b9a2ee1fa8c383e9f3261cc8409e6492be901308ce09897ba70d61"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.644-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a66164999efe31976a8a132ec494cb5782fbd9cae0c9bb9605a586944f3e313b"
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
