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
  version "0.5.581-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.581-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fd20585c8cc84e8feae81226e54dc708837ec4ee3f463970deef1497a7430f6b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.581-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6f1f17f46f325d609025fc86664d34eb2c8af512be832d01a8d1fc5cb7fa83bc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.581-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e36eaabaf2e8e664fd62d72eebeb624dc6b5e6e610bc54c890ef360b106aac50"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.581-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8b12a4664c57c9ef220648c071b3bb5c74bd54bcc641609b446ae3f238abe12e"
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
