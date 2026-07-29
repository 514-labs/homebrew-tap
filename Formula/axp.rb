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
  version "0.5.518-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.518-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f2898807c0c2ac0539a18f4a8b791f9913546777dd0550cda0fdfd5c3ce97450"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.518-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "47f78c548d2e47c9f474c72906489ad4fd6221589c279dea9c5e97aa2f155c75"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.518-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "95381921efb692428568375d5668d13e6d9351c6099c615cb4f5126ec69238fb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.518-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f101247391a8bd9a33b93ced4a556b9a1c212a6ed0389e0e3b95b5c79f9bbbb5"
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
