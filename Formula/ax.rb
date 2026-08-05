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
  version "0.5.674-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.674-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2aaf8d43e8e05ba87754fce1586726f55b23a79093f015e908c7945791278b8c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.674-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7e923821579ed4f63e714f9756612450a9efde0fedfc30fd492ff33b862eddbe"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.674-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ebd32ac8a923a65f1a11b6652ddaa3c0680f8378a7db15a961dd4d4f9162718d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.674-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f793ae90404bfb382777b17248eef3e9313c8afc2aabc39c9cdf7652f8061469"
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
