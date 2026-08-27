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
  version "0.5.901-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.901-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "15348999c8d8184193c5ef6fd5154d5ebae2ea34a4582b7295275d536783c06c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.901-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d26e9d85dda95a8460118ca5b623df6357216e930d6bac140e71dcee1d1c9f51"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.901-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dca19a8690effd30facd5398c2822ada9a6e4e3abfd887a7561983bebd8d640b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.901-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "da0049097e9934d7dcb06d0dfd96382a350aaf9a20453e139da61eda27370ab8"
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
