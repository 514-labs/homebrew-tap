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
  version "0.5.1097-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1097-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e14a66587cc4d3451d8501f114ca71e70ac8780d0b578443541b3e32c66435c2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1097-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2a16a4921dbffb8952a453c175b4d6c30cd34965ccd32a860acf733fd7a4b252"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1097-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "56bb228e352023e1b1db83b1fe6037fda7e4cec67d073248dda860ca03cd7bf3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1097-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "86a90e42dd7c1af51d0b23ad8dc92f92d255c5416213d3d73e566f2438c8d3fd"
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
