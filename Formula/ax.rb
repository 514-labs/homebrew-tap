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
  version "0.5.1017-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1017-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "52a559965b5d17f8798d057b737a4f85cd246f78a00adf99c07de146ab2e3f0e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1017-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c942800ed477523a6489e8d5d338c2fdcea61a76869d334d50d8d1486a249c3f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1017-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b3bdfa0f3d5bef6927aecfdc847dbf6aa46e2ea556bf991b4155eef58947ff42"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1017-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "df9acfd8f146f15d4ca5f2410c7fbf4a6d84d40020bd564f20031f21a1f3c983"
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
