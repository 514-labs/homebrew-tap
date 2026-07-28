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
  version "0.5.488-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.488-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "1028dbd2cd4aa7f6bf076c9fad922b3635cb933553f4ebfa40585ae300b03e60"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.488-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "35c63f38e03e906947fc66541a2b3cf0b86b9066e1b0cb1a3d08eaab2524611f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.488-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c936617807254b26c1be393f724cb4b2b4e6271f29e23499355343f54808c00e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.488-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b1f5d8f76c1e532911e3575c757c3f5c9a950fbe135c213f4a1593f3a1232b77"
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
