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
  version "0.5.525-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.525-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "265613beb0e085144c31b26c356604069ea01e0a1bb3b008a0a2611ae053d7cc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.525-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1a40ad566cac3a0230a4439f37ef8407a4b082dcbc253344d1f252e9d44cdb94"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.525-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7294643466f042da72a80f98c2678098a57434052a9a9ef55529b722f7295c1d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.525-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a1c7c08481d7782c3e863eb650cabef5d941a91bf71b1a81fe7dcdeeb5e3006c"
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

      Create and run an experiment:
          ax experiment create my-experiment --template cli-install   # your agent writes the YAML from your product description
        → ax experiment validate ./my-experiment.yaml
        → ax experiment run ./my-experiment.yaml                      # smoke: 1 repeat per variant; scale with --repeat 5
        → ax experiment query <exp-id from run output> --metric testPassRate
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
