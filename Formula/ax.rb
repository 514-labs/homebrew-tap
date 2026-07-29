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
  version "0.5.520-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.520-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "223e2f0245faf774f1bb864d9b4872b34dfb7c742a20251510564af9943db92b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.520-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f85207537c6c2c4ec84d71f611b423dbf7e633f5bbe36fc136ec53c2aa5dff8e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.520-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "229930cc95b32a6353f8bd04d96d551f82fff2be5c6d3c1c539b977debe84fd2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.520-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "291ae4658e219c600c34937c121d6ff73684799d27b39f4a85d955737ba89aa4"
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
