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
  version "0.5.537-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.537-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "486817e85777e52d16f1c85004da28f4f78c98e81d06c149338fc62fd93f4ca5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.537-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6350fcb9f42b921ad3395144c4b9de50f306c2e104f76ab2a94db1ed5bece271"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.537-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e943f6f2c307bceec4211f267f40b1031974698a4aed42255dc31ff1c345ed32"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.537-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d85431d754ed77cf6053abdf50587302fe698d3c5f20660c6279797b7139d287"
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
