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
  version "0.5.421-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.421-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "31cbbd6cc90e28eb15e52bdbeb95fa62b4954f9d9039e15bd86e47cb1df0db18"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.421-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1eabbe172d3e6ab7fc642e31b7ce7e76e8985b26adf86868c6f05eb1e794e7bf"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.421-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e220d75b834f47f18413579e9c0455d6de7545b345cd10f28006e956e9e36b9e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.421-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2b0e410e576e80d829638db5267e3f4f5dc12c14232e46638fa7817b39283b27"
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
