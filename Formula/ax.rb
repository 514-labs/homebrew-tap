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
  version "0.5.599-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.599-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "52011870ba8ea5a283aeb2244e5fd2aeaaa66c91a685c91e77367bee6022aa49"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.599-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6eeb6374f92aa055c724d108ea957595e797d37afd57f0932775dcfb1baf00b0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.599-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2a7fde872d407d72f4f9755f4d2d6a83a6097d47bbad25ea8d3cf6f51e5d997f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.599-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "99562ed7cbe52df5856b0628970fd9e95869936e6ec40c1fab0b2819f51a4fc4"
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
