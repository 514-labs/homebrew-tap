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
  version "0.5.276-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.276-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "78c5811cc1252edf261071c02b9a1c4cee1055e041eb7ff48ac692a643a324b2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.276-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "147ad0f72511e674e3c7bb50eb98cbfb7200f0b4000e9a6a3231c8fcf6aab8bf"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.276-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5d42abdf4e60a051b30550b14850c071f40c22d78f421cf3beb396a0e197a512"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.276-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "11dbc9e1ea7eb284f54e34a0e37bca8fb41ff7e7fdba739455e3cff20afdfa14"
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
