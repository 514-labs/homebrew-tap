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
  version "0.5.377-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.377-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f17d0440742d68d38db2cf69c4b768880d673eb24566fc1d4940c2b0dd8fdb2f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.377-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "cc2e95cb37b8f3d01045f442b96a79602a216dfbab2abc6840ad4ecc29a59062"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.377-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fe2ec150ffa6717a5f248a2bd6c3937d8f2c967f9fcb0dbb128553058a723280"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.377-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cbc65efdecf95c308ce973c486b60fd424fe88b1068e8da0a16321f27691f87a"
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
