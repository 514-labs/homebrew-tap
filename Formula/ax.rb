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
  version "0.5.828-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.828-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3872d4fd345b80974466afacc6684813447268ec4fe58438124abd853c0bb813"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.828-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "63d55cbeebdd4cf4df64c4ce873eb53acdcefab7cc5606fb276e57e79a6072e7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.828-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3ae131670ce1f9d35b50ab2fa2264489e7e57465cd1d8e82aa7db036d01c24da"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.828-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2a0971b719d50a8545e087f58fb39cf24bed3c1c50a7bdec2bb9b8627985412d"
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
