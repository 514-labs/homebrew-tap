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
  version "0.5.413-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.413-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c7cdf21f03239dedc354e52afe2a4de54d644c53289c22dbaa03d278bd1da7be"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.413-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1252a40fab296d1ce6f33cb76afe5d5e75166168f7a888ac4fafbb44371d01ec"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.413-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2c298e84fa5060c1f923bc5594261de088f47680d0ecd94681f3c6ff2272db80"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.413-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f18a3622fdd396375ed0180279e8a4606aa4982700b2308e48125f5620c19d9d"
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
