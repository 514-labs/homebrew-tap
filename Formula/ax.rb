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
  version "0.5.484-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.484-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9d9ba93f546995e6c3f328c3a051a8d2da50057f3aac44efde9c38f41f1b8607"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.484-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9e63034a905951e4f2b343e39c62014f11e52dad4ab7e73440646ede2b61c4db"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.484-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5f997db440afaf08ab8392863f72efaf971b5ecfcfca98b4539ab1ba8a4df0e7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.484-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5f6561b0d044415ae0d8620902cd361543b9cc04a0c88b0a291aacbcbcfe4a4d"
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
