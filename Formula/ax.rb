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
  version "0.5.1078-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1078-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5fad2d9215d9ae00b2ec5d74247e595eb303c0ac9aa6f35be0b48b0db6a31f42"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1078-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "492cf935ed6448bc965ce5e8314243128606d60efca6fe92d34909804a890980"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1078-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c7e687634654e82a944928613764d910a5daedea5ba5f405fa7a367fe62a1027"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1078-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b1eec4e5ea6295da31e99f51c0ea3efda010db061e35ee13ea3799399b5b5ff6"
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
