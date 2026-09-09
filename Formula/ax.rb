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
  version "0.5.975-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.975-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fafd1f313e9d355eb1ed5124551f2ddb5fb1d9bbb713975537ec7a1613588804"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.975-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4349aeca2c5503a4c73573876a184601438be0161e9efe50ba6693bde962f3e1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.975-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "eece254e09f10a32928820bdc660e88e880f98d43d4a64d5d3ee1a108449db9f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.975-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2e40a41fe1fff398e0db0b01bf3b2e72225a89597258b3c7e5b5577f0d0183a8"
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
