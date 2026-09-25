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
  version "0.5.1141-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1141-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a6cbe8a1d8bf02a2952abc89bf2fecf736466f68fe8fc79e81071e1542d929f6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1141-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e240bb081ffd13b29cb020be8fd178920dc0c2084d3ae815b433c8578bf7e2ea"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1141-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "52ad6cbaae4c2ede547a86926ad3b02bdbb5aacdf07b4c85018c8fc515aa82cf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1141-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bff95f9bf03a221c0e9775d92493731c6ef6e19a6da5725878179f48a021f054"
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
