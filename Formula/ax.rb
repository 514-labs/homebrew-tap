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
  version "0.5.384-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.384-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e7fa905e0ec8fae3a35ae00caf8a942878f39fe0ae5434a90de242dba9622f54"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.384-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1fab311d0c7f10a35fd3edc1d26f815a9ed9a0e027b9af05bf48bffb09104d4e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.384-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "439387c8d226a36ceeecb0c49620c5803f4b053fcc484d26fc37498931b4cac6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.384-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1111d20b56cd5f6735494996a12c1321a3243f81ed088e1acb67ce2e2c1a4801"
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
