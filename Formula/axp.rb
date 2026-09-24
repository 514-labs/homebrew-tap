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
  version "0.5.1120-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1120-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9f91517d598d7c25712c46bcf0f58060eabb2c4c2b1a94b51e26fc420a63fce8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1120-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0aa525fb0dbe50605774f59b86dae9c18e6f2907c6f8c371795275cd649a4883"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1120-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a78c5593e6302acb2b019c2a3bb02bc92c53659aef9b762e92bed5b0f223ceb7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1120-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "966290814beb5c375a535c142c64577f73786c4ef5a2af2a90bec1ee2125b629"
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
