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
  version "0.5.616-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.616-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d7631c925058284df5d02f097560c1ba5d62f065897c4cc8a7e4fb4d60150b51"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.616-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5860023be423f83b15385e3a64c596875a0a388529077bb318d4a3f08aad2b77"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.616-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b235f8b0c38585c87c42918dcb656b17954e3350b42544d93a19b70848dc4708"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.616-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fed785d31c0568bfa78f680dc59abb3fb041648335419fdad83d177a23596ba2"
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
