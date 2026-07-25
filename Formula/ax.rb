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
  version "0.5.443-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.443-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "930e1a4fc24527bfee96a2bcf392b7a95316206c1d7c81907e6def579433ba1b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.443-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f340e552ec557593b39a2d74247aa81c580cbab8203312ca7d630d2ec890e6a3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.443-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "223cff939282668d1cec44d4416af6c9da786202f2985860627c62dc7282b9e4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.443-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c3bb7a81d599ee3bcacd33e411d2b2f3796a950211e1ee81df79c45c17d3e7a5"
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
