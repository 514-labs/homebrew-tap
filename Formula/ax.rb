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
  version "0.5.608-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.608-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "92768f522d64db6b0681e357a5c9b0e821a0261225e5d9d88b271fe221fad981"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.608-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "35093d19f688f572a7f0c5bfc8b9e019417347385b8e500c6845880ff13fd450"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.608-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5e36e209487b8056afa3d47363e65e237cedc87f19fc297e8a0e5b0fa1da6c08"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.608-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "44b9ef7d4d94a5f304ea76dee7d76ea15969eb7f24f56a372fd8617d8b674fad"
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
