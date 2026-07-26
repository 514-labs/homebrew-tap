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
  version "0.5.452-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.452-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "17060ba692ee9b186fd18c1bd3fedd855cd960e7b96a7daca0df901bdd8dfe8d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.452-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d65bbb66b2d46a459b179bfe9bf473bc4e6303ee5d46f20dd4586315f8b125d6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.452-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "35ed31b074935d0c18f53c895955ed84e986c2abc0f6b35757aa05b489089a9e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.452-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "252acd9a0175ba988fa165150075afef66d5fe270bb65dcf475951cadd777edd"
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
