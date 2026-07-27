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
  version "0.5.466-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.466-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "aa1d166c02df67d1b5cc8cfa69d618d9b7f2265807121929341d927bd77722bd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.466-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ef5eedb847f870d8a46e345593990131c98ef42a79e798b12c5c6e307d345799"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.466-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ea64e6201886a90a4a140f239155704e244d0bc5f20321ca8696d5854f8065b9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.466-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7066eb18ea4bedeee8fb0862b2f4d31c82e68e4a1d40fb3b740def85d7fad1aa"
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
