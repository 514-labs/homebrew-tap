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
  version "0.5.397-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.397-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ab376e4ca361e39bbc591ee5567d3991e12a0548d19204c5d2a64453bb93a3fc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.397-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e4864c92d06389a13d91b692e7705a89450870eec4fbbf31b772ac6147fd4679"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.397-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f371f50ca5cb661655a0c53c4b4faa191bba4df8ada31661cd902dacbc7eb7a5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.397-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d6a72482844343a4c09f506994280a6add4110c94619bd411dcc29d4479857de"
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
