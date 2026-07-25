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
  version "0.5.439-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.439-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "94c021f98256e6dd863f6a391d5a3dd4555ff5c06d731d8ac8fd67fef7d1492d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.439-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "df82cc0952122ca782b15a39d4b882dd30ac238a0db055ba0544bfe8d392d8b4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.439-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6e462507444b0738323e1f9a34cee7f2ded2c1244251251bc1b9f53875309559"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.439-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7bfcecdfd8e33a0bcd575ee00d3a14d66c707f63b54207ef1ae3ec9fca205c76"
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
