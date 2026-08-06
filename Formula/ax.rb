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
  version "0.5.687-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.687-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7b18f3e8e34382ec41406b855e1a86427a964d9250364f43a764da12f59636ab"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.687-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "94e7d616dfeac3541ed898ddc5b61a26c5978c077a1933a17210466734e5ba00"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.687-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6bcae4cafce1f8283d55ba93da9e32186cf16db43f407b5b7a913a1b15753cbe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.687-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "81e5d1c9f85820772bbeffd1e8bac8c133a48b8af832d0424a79c26bba55c415"
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
