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
  version "0.5.373-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.373-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "56ffd43180e5ba8465a72cfeff8c5b634b671068cb6df0974dafa4fb5574c1e1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.373-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "972e1e9ff4cb36eb27d4c5d8c83d19980cc936f5a9a6995aaa746f1d6d2764cd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.373-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bdf235e6f89f7131208ad0abd2d7583bf5eda470b37d10a7e7c7a2994bb51ff7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.373-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "91f3e8ae6aa2a4cc7b4f615dfaa2747575d20a6253876900edb3eaa36bbd5eb9"
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
