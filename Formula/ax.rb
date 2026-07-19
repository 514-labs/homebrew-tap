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
  version "0.5.295-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.295-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "beb1c892a27f01dc4b89dc7753638437ead56f9b04f4e25e240edc4a49be9746"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.295-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "153b6fb59ea74a19728189add1e6f7babd30a7d71a91763b3cd53d2dd23382fe"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.295-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8aa3a364504c617835a203a1e6f2f256b1a5d2d678be469b9bdf11c653624b9c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.295-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "87010c09ac174aa77be29a3ce1536b03a0dd883548a904271d0d260ab261f526"
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
