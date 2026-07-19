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
  version "0.5.297-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.297-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ac06c853027ce0f6d630b1bd76832ee9cd45f88313dd6c7bddb429ab9a87687f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.297-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "aa7116b0a0f1e33905b42a7a2a738b86bcc9d83c4abb823c9bbaa441020405de"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.297-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cfa4febc011cf14d2b0697d67eb40431182f9a1012a97bfc6b5e023cafa8f309"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.297-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "435cde7e00c9ef9e4a7d3ac6a5eb0f412d47cc6a932618ee4202565d734c2144"
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
