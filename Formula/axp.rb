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
  version "0.5.325-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.325-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f481be845e2cfe78bbf66bb31f1860456fc3977b83e6c8daa861df02186b4445"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.325-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4335c58faba4df2324f29c508628bc054f3321590a49cb6bb97319497d202414"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.325-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "66400b6a223e9aaf5ea68d35fd3c40c67d08a385c7de514396442de41f98aa62"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.325-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a6e6396c23ea2d4c4ad3afe858d0bfeb13f5f3662799799048e6c74bd0be6988"
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
