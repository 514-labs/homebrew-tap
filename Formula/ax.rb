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
  version "0.5.897-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.897-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "daca310eb80ef5f8c05f90c17d6bc51a7f8799c5b53e069d2ae90c601d356f93"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.897-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a574da20d0dd0b0999e3802138c7f9fbca852519d8a507f3703b4fe948722d00"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.897-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f84fc2ff4c587ced8a51b61db20ace678575d164604652285bd1a85a89f31493"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.897-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dd90c05f7a5536eb896ac009ffeb4c2952059632a73b99121cd0bed842ffe32f"
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
