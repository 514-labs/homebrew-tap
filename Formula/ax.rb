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
  version "0.5.306-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.306-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7a13350f7768c407e12a3d2f4eb151a736a5e6b7940a67d81a3bae9be1ac5911"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.306-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a02130d0ec8e93326999ab00ada25f32b29b8a44ca277ea3ff74a12b50451f69"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.306-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0facd69fe3010cc834948faa8efe788dc312f75970c56aeb71c66026b4d3898d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.306-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c6f85a88aa49822b1fc828265e14381aaf625fa1a11a7589af133fe6a1ba9f6e"
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
