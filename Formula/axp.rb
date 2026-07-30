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
  version "0.5.546-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.546-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a99c47f80373fb8b0e4960e8785d02ecefeb5b089ea43a57a405cc57a7045d82"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.546-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4466afa9dc793ebea3b9ebf3e10707f94b09d28909005367439976e274532203"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.546-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f26a83b385bbe54e9af68ae726f9ef0e48ad3322f92ba59cff71f95c5d0edd7f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.546-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fde2f8ecbf5c8d0f8e8f206ce0ecc9bfd5836c7d666a13907c58011af97d2d2a"
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
