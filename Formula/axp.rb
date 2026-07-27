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
  version "0.5.469-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.469-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "63ee63aacecc26a709643d8d5412400a9e2aeaca1e69579218df2ea0978bd2f1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.469-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "18338186e7e696d126bdbce630f93215e60e31b5ecd9cbd7b1b06583a4f91331"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.469-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "175532d8d7a2d58343fb4766cd5d783a47896a91d68850ee2f5a63c7a89ca371"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.469-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "00e9593124241b4f203e549afd3dffc092e837bf6039631afa4fab738f99ffa7"
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
