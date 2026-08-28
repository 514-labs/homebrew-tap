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
  version "0.5.919-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.919-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "589b18f332bc8b44046acb977f649029b402072892140a470701c2067ab9431c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.919-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "71603d24cacbb0647687209aa373a8454ef1a8433f3fe413b71c0791894fa0ac"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.919-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2d64946ee5bb4f197982d5dd46b8cf84d537aff14853fcb08d4d565f1de54a89"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.919-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "54ab4639cbbc98119ba81419f7acf61aa20ad8dfc4a4bea017d3caab6573f0eb"
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
