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
  version "0.5.487-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.487-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6240a440053213af0041dd12221baa063577d810d83facc88ad80c67e5c7a991"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.487-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "88d9694c870925709604ff3a48029356650ac8f1c8dfd78a9af37bb646d19cc1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.487-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5e4ed331a013e2518cc2918f516d5f0fe9a29b15d321b1e9917f8ed3ed2b30ae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.487-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6ee67fc94e4b6181b06b56ba920e5d54c0da6158edf02ed829fdea27c5b85923"
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
