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
  version "0.5.539-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.539-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "69bc271bbf0a21a02a87c3fb8fb6a540e678665db420774bd2870a87b8e07724"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.539-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "94b355f2890e47a4679152038197f5db3e88c1e6fa2fc20d7a84fcac6424a504"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.539-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b7fb6abadef7709606c2ae5107ece7b679be15e5cc3bbb7f6c41b414d0acb946"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.539-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d9fff903472b2a3b6fd9ec739182c72d84c68fb1a1cc5ee78b4b992734713e2e"
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
