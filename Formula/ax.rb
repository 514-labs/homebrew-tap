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
  version "0.5.278-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.278-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8916ee9f4219e2ac767a217d4d926f4de48ac5acfe6901db5d499b0ff4c5575e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.278-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2d90dd737d371976ab59df9b1f56148f9b60d7d5141c3d08a21acbb3c72eb1f7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.278-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "18428d8dea45351689b42b5c95a7650128061ca1c5b6a787759ad5b1317f0ef5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.278-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4462251ce6df239239011d0149365fef19c66a1e290231a933cc38590f8ec7f7"
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
