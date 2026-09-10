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
  version "0.5.1005-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1005-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ae525cacf9d580c5ac796f053dd906a44bc4515f24c388ae5b669fab85d85e33"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1005-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4cdb4a39fc96e0b63dfed3f8580d8189bb5f0201d78f5a66e8570b656cb692cf"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1005-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "87a5c9589956141800ee2b5b11d1865aec3bcbac6cefbf6bb611835cc319f4de"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1005-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ec7e0e001a0db394adf8b58a63d3b9555dc126a079d7c71e7f2a994574961afa"
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

      Learn how to use ax: `ax learn`
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
