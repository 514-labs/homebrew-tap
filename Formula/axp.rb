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
  version "0.5.1117-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1117-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e8beff6c074d04ea3064ae470f383117d68a24c3c2e017ba394ce7b5fdb43efc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1117-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "654bef24c255df7e25ef63bfa929bcffe3e9ddedb868c45f9bc291f78294e306"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1117-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6675d6575d621317da060bb72a6476bae8785627e6060f4d68c177ede9b6337c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1117-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a2cfbee5cf740a5ea86c94debc8a5744af562d57e701f30780fdab3ee7583e56"
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
