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
  version "0.5.543-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.543-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a736e19f1fad54d0f3e90a40e7cd82e3a767bb5502c704630526c7d48d649021"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.543-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "8613efea29beff4063fd26ff092f44cee5776e643a28708fedc29caf02fbeac6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.543-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2c5f5937460b643d0c7c90dd48ed82e85ccd784865e970552ba8db06388f509c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.543-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bb1fcf8c63fc0b9b7496a9d280dbf77f5e91980dd28eee27c4b73dcd3683129d"
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
