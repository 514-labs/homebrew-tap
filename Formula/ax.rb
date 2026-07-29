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
  version "0.5.527-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.527-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c26d486cd36daedacd1e3c42d558d5c90a5e5f7758aadcf37874a723981e60a4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.527-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2d4ed08580310d1caef3396769c12f4c322bbbc0597df4eabd2f0cf17bbf8b5a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.527-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d200e21aef57a0660ff35a18040b75f7d2b86570a4035a286eb1e2ca2e2dd1d5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.527-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1818b54290f6f80735ddba49b092795c19cbb8fe6c9856c1bfe76cded8b25c89"
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
