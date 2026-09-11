# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1022-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1022-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2c8ae36f02dd15cc3a6899d0a92fa3177f8751fe74b5a84859da33bf4bf1378a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1022-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "8d6e693627ece7388d2b4b623818e67d79b173024aa9759ad70f5b1b6464f6cb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1022-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3fdd46c4a071d4a1758dc34a06cb4c5123a9ddd3b578d57c84acb03fa40da712"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1022-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "903483673a17951af3181b97b6a21b9c550251f2af31284551a60d41ed3844d7"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
