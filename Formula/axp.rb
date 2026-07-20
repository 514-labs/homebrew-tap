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
  version "0.5.318-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.318-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "bf0ab006c1913d4dc6c5446f76d67e2697b1229c0dc1964d4f80344c4a284c9b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.318-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b3ec85804bb8c722ded5add375f14d78429faf178a5cd33bce6f409eb032faf1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.318-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fcf5eeddad5238250135cc3f3d61eadd6b047b255e6f771b7f3b823ddf151e4f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.318-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4ce30f175e21cf3d681ce148c943e24c20a3d5bfb1819de5c46b5c30d535023e"
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
