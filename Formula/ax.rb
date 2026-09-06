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
  version "0.5.966-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.966-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "268855d50234c56f4067ce7ad719f8b5a730feaf3cdc1fc87592e98b65c5eb66"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.966-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2aadea1967cb80e4703ca459d19fab543692f0dbb095ac7b66a32d043dc09d4c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.966-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1906920ff69697ca06845c2b83f5ac023c4987c183d6ced4b01ea106aac81013"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.966-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c0524b5af84f64c00708e4119f134a0c9485d6fbf0d8a27064d8d8c44ca629f8"
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
