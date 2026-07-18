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
  version "0.5.286-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.286-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f2b8d94e858d03055a50329de2959ab8cc82300e007510f7aa6b63ee1c18d7c2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.286-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4faa9f9dca56b3a71e845b3884d3ff8bcc9d0609758bfb8d4756c8a554137eeb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.286-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1ad6f3a0fea60a713999edd65e881f5f0a91816e0b5716175ea1885e2c7c453d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.286-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5c1e58ba6b1ff6561501ae0a2ee9375b403e2eefec3eabf18c288de75c48fe5f"
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
