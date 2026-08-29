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
  version "0.5.927-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.927-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "79d1c9db6a8b540976841351cafb0df33abf697c809cf5a34af1298146e63090"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.927-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9bd15962340ca12a80242ce5af0862be61cecfde5a9b8ce8137de76bc4ad6f09"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.927-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2b2b877d379a0dece0003ba664ca60b18b47a5fb338d55bf12a9bbffc30c4fe6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.927-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "81325cf71a233d4e0a71604062b42f80f35665abb103602782bf22a601d45277"
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
