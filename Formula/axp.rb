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
  version "0.5.427-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.427-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "baf2a4b994c2ff089d825e54fc9bced12b46714e729c06bd7bda868f1523164f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.427-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b92579995161851d498c7cbdca310348e2f9fb4711af5d70ad41752cbff817aa"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.427-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "29b72d60bc926b73485d91643643311fef467f28c50dc16f52706aed0239a179"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.427-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f59222bc45d5d9fc7754141cae83ca9f0d3a91128bfefd095959ac26c94d5d67"
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
