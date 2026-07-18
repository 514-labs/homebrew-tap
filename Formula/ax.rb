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
  version "0.5.283-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.283-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f4b96aff7e37fb9d3843e8ff0b41c4c35f48df3db28230532fa3cd814c5ebf63"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.283-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "99acbff2f6e38fb906dbe94d446243f2455d24d2cf2ba04e54d83a30db415d1e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.283-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4663876ebe6dcd33611018d4a601970d5b97ba883eb2d3482488d146c62e87a5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.283-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2c5326c2eeba1c6832705af2d290c58b7ad7f06ef4ffb17de2ef9f3c063cc165"
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
