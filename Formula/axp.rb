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
  version "0.5.442-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.442-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8c693da2fa3a8fd76bcf3e6ff32f33c01b25b205ff8231928b2810027977d102"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.442-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f18260a370cf292bdd0853366b827ff13502b2132a9234fb0b4448d27ad0885d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.442-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "59fd10d7027d95f9a9a5f3e1b900c5ee3f15cd6c9b0da17852c7b02fa6c8ac8f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.442-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cfb630ad99fb32312fef0011eb36e801a09bed753f57c2b82a0caf451cd3c5f9"
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
