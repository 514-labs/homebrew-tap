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
  version "0.5.435-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.435-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cb9e8dae7a1a11b13c8e2fca0a82b729a0c52e99bb5949f3dd459496877aa54b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.435-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d0aed97fd1c54bc5d456e7c3cbb479e0064ccefbb9810222dc0e50b65ce8b442"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.435-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a20e5e7e7fa9ee69019bc0d9ebf8774df73915ee6605f45093480d6f047ac573"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.435-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cfa56086f4c21041bfd92f18e5510ead51f0c65d26c167cf33fc3514ed8b640b"
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
