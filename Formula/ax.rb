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
  version "0.5.917-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.917-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a41f550aef349b86572b7c36c34a6cc0a3938b209ebeb153dd9c53099e383d3c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.917-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "05d9c17cfe956c8aa06483556d855b77de547310bd81c570a8ba83ba1de71a58"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.917-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "06ab06d3dbb71a419fb79a1e56ee835d5599fb3b6f9541343d7568b8b9d67e2c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.917-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5f8396800c8ea37e6110d4791657cea436d768a994400460a3ffed5e0005f549"
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
