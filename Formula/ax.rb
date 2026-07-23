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
  version "0.5.391-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.391-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "142454ea204689fa5895b668c8b1f8cf7a4da8f5ed57ddd4ec90ca3950b08fea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.391-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "cbf8cb5a6c7822effdb0d737c270c039e69656af8baf82acc0cffb7cfe861d19"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.391-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3f27e7f056eeb161520a74b4ca84b64e7b76e38c2a5552b3b659453e4b0e8837"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.391-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "836c821c15cc13cbda6ce5b63514b487f3ef3d1905c224d10cafe9138085b60a"
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
