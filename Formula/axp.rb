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
  version "0.5.308-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.308-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8efe9185b7d566f0ad0514462f3f1d1a77a12e77e629754574d00c167a3f40e9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.308-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "19754fe8fe8a63152976186551d85c2b4675ceea22957bd8302e0e2c0ba18bf2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.308-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4943f8a3d4b2a0c4ac2e320f5b67751bfdf5efc27f3d03624af9ec37433f741e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.308-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5c4b492204c17836d786fb96fd0bf183b5bd0da25d301a7e2cbd369db3d22ca4"
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
