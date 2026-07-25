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
  version "0.5.429-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.429-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "211999b82314e0025e940888f4dacf86bf04fde7867fe2106a0570fa1e92e9a9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.429-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "730e6f66637ca0074f28b88ff92e3da31a6f101434431bc93f0c7acc05c2fe63"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.429-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7f2b066403771ef22c82d3cea4f448d432d15695566fd0fadc410b2871f0a17f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.429-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "04580350b91a19c9d44ef7ba6a6013d68d49e8a6cba943510fe74cc2f6d3efed"
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
