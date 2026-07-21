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
  version "0.5.327-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.327-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c3d6126d7901b4a418cb408ac7b6a99c987fb3a511d200efc103111e4031bb0e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.327-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "806ae350836c0e63bf0591691adc4495de4e4309ad6c5d46640f12940da9532a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.327-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7754cf5306682024d2c803f1aa1f483d4a59c63d614b36dc773e5b7e0383853b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.327-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b24a40cf050127c381cf936ac05508fd67ed1430d16de41640a26c8201fd3298"
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
