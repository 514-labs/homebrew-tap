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
  version "0.5.500-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.500-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "dd0af5b023420e21b442800f8314bc8c44e0ee410387db971a9568827f1d3e31"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.500-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "32c0b54b48eb1d5bd8690a20be1236121ec5b93e647516f5fd980ab3e95100d1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.500-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e5e4a4e0a7a3947a4fe8ff4f6948c795e69fbf7546997078f403bab455b2b189"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.500-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e89684a1f169c0350f5c6854a808ca84ded3279759ea1daec48a6d158ad0aea0"
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
