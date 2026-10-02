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
  version "0.5.1243-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1243-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "97b857da80ac2d22606a8f9832d24ee675b0dc634aa9ea4e3d522d164d0e90b5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1243-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "dde59d7cf4406deba29c6a746a1c29088e5fa14b65413b51a2f4e8a7d8544a57"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1243-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b9a906f5bf687fa564ce1d69603e51495bce8ee45959cd08ae6bb3dd7565707c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1243-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c4754e160613d1206e6bd3faa608cba3783ce18ce8af6375802a3d89477a5535"
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
