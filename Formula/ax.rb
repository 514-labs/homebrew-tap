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
  version "0.5.1139-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1139-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8efb6f6fb20d3506add727168dd5fc092745b86d9187a6466cfd4cd449f69593"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1139-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6dd4a4da8608ec9bfdda73a19aa43b70836b90dc1a2440a8cc8bd25b6e08cbc8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1139-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "62271367ae34c4baef05f2e6fe971a5a925035b650f31b1564b63fa851f1022b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1139-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "97ee5c7b6262dd966d6382adbb9f3882a6da7ddf3c2154c9223302d3d885a62a"
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
