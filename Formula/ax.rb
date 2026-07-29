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
  version "0.5.524-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.524-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "49d48ea2a7a404ad38258155906bd06dd716106bc3a19cd65650590865056ffa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.524-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fa1ceff9f316e9d50a1bdbc092534d293699ffd2daa7452e38b1b3490748c402"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.524-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "49a03a8c564eae7087212835752f354bcd092c701c2486708ccc8565db047dd1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.524-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4797f38a0b5adb8345f0138ff09d65316d7c35619f9280e63b79a8738b88f8ce"
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
