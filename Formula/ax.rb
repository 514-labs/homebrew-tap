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
  version "0.5.346-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.346-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b999a1d43ea58fed863b824e1d515512f280d6bdb1b489a11ad90e113840d870"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.346-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "440f96dc3e573c6b81ef3b7af7d35896d2469388ee8f275007a6fed995a9a329"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.346-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "17acda577af11e4068dee65e9e0e0b4ba3332d60e59b95b0777d7e2d596e5a88"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.346-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a3eb5ad7b02f4ba35d2949dd25d3febaf36897a025c0f2ab3186e0ba3dad9784"
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
