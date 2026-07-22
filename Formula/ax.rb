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
  version "0.5.357-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.357-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4dab9d134fc5ff5783bacb7746af80b2e6d93445312c7488555e84931fc897c2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.357-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1ac6b7dddd8e374169ac0ccb3dae387f070b45df575f9753aead164250e55739"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.357-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "30430352ab9e0ad7ab26493281a0e951054b80103875803e91cc23e0c5e5ad91"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.357-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d3fd2cfb2f7567844bb5dba7938d943acb4e0d452cc40b4e7a010f114e2b0ad0"
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
