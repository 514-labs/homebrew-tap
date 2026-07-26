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
  version "0.5.455-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.455-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "871ef8bddbb6b5928a67d9d558fff3f384c18f7ba487cdcf82802953273f6d36"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.455-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "676268b1256d155bf7b994934ad5351665e897c2fb1e81309d1a1efd4a55a94d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.455-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fe49813eafe1d56df90a0297f9150ea954d8f54567ddd9a97a8db5d08be0a434"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.455-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "341cd67aa0e51a5e6a179fa3ca515e527cbc70d662546a0d51364fb878c7a380"
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
