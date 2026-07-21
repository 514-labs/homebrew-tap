# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.333-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.333-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8d2fa0587fec48655e3a948159ca67ab6e4bcd79b7e7d3de5edc3c2527e918e4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.333-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a6ef3a570349e55b5de5d4dbeea761706e20d6061ff298772f3b2d5faa6de7d3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.333-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d97fd805140cebc83854c0bcf0731b3407df1c190f00c300a3a1d42fb0286ebc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.333-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c0873192087074f284b17ed20bfe0964c19d434e82369d28eee652a67fb4e78d"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`ax.tar.gz` = `ax` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
