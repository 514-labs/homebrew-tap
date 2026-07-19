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
  version "0.5.294-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.294-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9ebe180f9df9feaf24521921545dc23bc98a204c0eb015af3af0628b23615910"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.294-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9249a392a5eb2ad2e287b9700c1ec49cd00ed2c274f462a1d36a41d8d78287b1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.294-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a9da5c777c06caa6122c018f3817c208cf0b714551f65e4fd874fe7efbda8353"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.294-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2e342352c0b2dc8a0e4e17a5eb776d092b1a87b4ecace314708c0ab9908b46d8"
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
