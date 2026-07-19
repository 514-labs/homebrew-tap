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
  version "0.5.296-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.296-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1b891bfb00dd2f6a0288055e1f0ce15ea72bd2d4f6d29173a54ff892cc149c7e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.296-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f65ac3558dcddfdddf4fb0d8dec61af06e086e5dc9a3d9a6266515a5caa46982"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.296-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "00e0e68ea9c6be22846f7934f8be67dd785167df6921af1dcfeb06aa37c4c2b7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.296-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "58e838053cfabc8134b831dad0367e33830e815830775850494bbfa1f9deab5b"
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

      Create and run your first experiment:
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
