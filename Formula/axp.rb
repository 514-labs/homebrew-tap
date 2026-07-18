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
  version "0.5.285-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.285-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e6f43ad8a173ac9c176b620a2f470549a654516fa07a054af102d7b6b4da071f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.285-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f0844e620846a2efe5b170eea5205bf85746d4ebaa43a4eb8c5624dd867e8cf6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.285-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f3b907298c62b99b3fd116bf13c1199ccb61b4b1a60f5720b1562ad2dafed4f3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.285-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e80fb031ef17b4dc7c9a545e6e64d8bd8aa66f1a05f2889b66b891fa912a6a56"
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

      Create and run your first experiment:
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
