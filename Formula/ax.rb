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
  version "0.5.930-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.930-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "060adcbc49d156285b2e97b997529008f738e54f9662328a49ad569becd59a21"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.930-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "77ca746161b6891c313a69ef869bddc16e91c8edfdec88ee2e31ba264ce6b2fb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.930-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d318e2434bd568e5b5a4bf89413ff51a38f2567a186b49dd92d31e6177b618d4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.930-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "61ee5560c49be71e89b4fb8883ed4bb400aec0a4ce52d3faa19cd85dbf297cbd"
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
