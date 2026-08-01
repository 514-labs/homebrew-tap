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
  version "0.5.589-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.589-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "636a4837fedba0c7cf18910f8e105bfaf6efaf8341c4cee2b10ecfe63b08d644"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.589-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8c3ada5eed4b9d6eede400debae04a1cafecf6b95fae4799aa39843c4ae53b8f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.589-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "67737b457752298a3ba0a6d1101bb8736d3d9a336927dd8f338151ee9dcdf633"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.589-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a349e6d83caaf3335421e172fe21d91ae009d24f8273cce218f8d84a1ffe66f8"
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
