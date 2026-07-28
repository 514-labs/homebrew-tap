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
  version "0.5.490-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.490-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "db0a349c9252ec7a52d44a8603778068996044526e88770008b1201d5b8ebbf5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.490-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "32f77e3b8df5b216b52e5735a2e46246ec8db1cef27c0667770c09518c07422c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.490-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8f22bc284005880a34e565044c978670079e993677a3bb72136eb83eda7ee286"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.490-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c353826bd57a2d59a7063a1d812be9874f4e7bba73022318ce20fb10f1478e61"
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
