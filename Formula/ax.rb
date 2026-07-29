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
  version "0.5.528-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.528-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2e580fdc9dc91837d7fbc6ae3a4e9b90266a5480cd09e17a85341528d0d695ef"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.528-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "319da7e1f466de002e62d22cdff51576152f0f698e0339d47848e99c43f358b4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.528-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6a06c09e4726074a65a7d0c13c48b53cf3a7a37c6ff120d564a7de9fe45f1382"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.528-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4b1505ddfce9f6fdaee57fa1e7a500a2591b5ab775f0b00a20384835f51c80d8"
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
