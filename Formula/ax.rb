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
  version "0.5.424-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.424-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "89e84c3b3e4f11a2d84cb0ad82e8374ae5e0cec00ea1e9e174355958cff74a33"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.424-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1e42d7780f3ab7fd6dae13a1f90d4efb42790523a380529fb79386a3f3146d04"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.424-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6bc749f96290c73df24000c01e428033e6418d2275b0c490b823ec142901b39d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.424-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b6d506b5de32e67588aab47a3e3cc93b58932ac8561072e648588481600cb336"
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
