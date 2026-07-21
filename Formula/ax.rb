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
  version "0.5.344-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.344-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "02d0df7ac20b24740cc900293f360424674c0fd364f9cfbcb1d56f5b486e5044"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.344-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "970e7a9eb2ba18068f0a6574f930da4e567e398f0913e1d04d557dc3e75b76bd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.344-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bb34d134d7b6a439e3a4400928ceca4f3e3879f95aac0dee3ddce56265931b40"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.344-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5652b7d9fd4cc1939013a30b655468f14f6dc45d00762e58b5c51428ba835bd9"
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
