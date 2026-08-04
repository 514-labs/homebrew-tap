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
  version "0.5.634-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.634-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "80550ce5412926c048fb983c8bdd9c16048e51e8b2568e98d5bdf68bba75d1f8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.634-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ad8962fc3ab44a7e538acfa56b1d416d3264659262d7b0f02a0ea1fee0f809fc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.634-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2f6ff7e1e03f014d31bad427bc3eedb789ff57a9f8eebf99eb9e42106dc790ba"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.634-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bc413253fee482136511518d8d17a422ec181ea9ba2e61eb81cbcf5767162547"
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
