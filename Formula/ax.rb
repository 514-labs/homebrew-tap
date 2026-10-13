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
  version "0.5.1339-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1339-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3c99b778c9699f3e33847b49396a728e04e26e34c99f6677732bcd26b6cc0469"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1339-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "37783673e69c5136e215a6cd2d1092bb11b46cfdc6b611d2f74e07fb48142197"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1339-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dc21ec255ef87fd1ece602ea72452d07c5edd9ff843e9202d49f61d696364dfe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1339-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "80598dc0e8721e3ae39d481d63ca9045b38208baa769333a10047052e609ebbd"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
  end

  def caveats
    <<~EOS
      Sign in:
          https://app.514.ax/sign-in
          ax auth login --token <token>
      Then get oriented:
          ax auth status

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
      Already have experiments? `ax experiment list`
    EOS
  end

  test do
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
