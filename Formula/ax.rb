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
  version "0.5.366-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.366-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b8b3d0c7c945fcbe8dfa479c2bd10b59ac1aa1d542409391cc7e1611f7e42c78"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.366-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "eacc65db2b4930a7054f509d694c22af3907c5a85e36367d9e077605f76cb057"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.366-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "60ff427acd798c1252a4e6d9fdde3b82438923fb4f650105cacce68fa9e878e1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.366-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bf2dc4832e03ce3b0528185e290cfb23ca6a6187cb0ec15cddb2c86bfaeed007"
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
