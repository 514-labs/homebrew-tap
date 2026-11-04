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
  version "0.5.1636-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1636-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cb0df84b5d2f5765986117de60f88a6034119f33e94d2a3f4bff7cf0884433d7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1636-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c4545d0e4bb47d41650614ca75f10dc72f2ce4d172f953482d79d0d6497d8616"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1636-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d6a6b57c2a5e0ccba6521c9aa2a5ef01461e30093efc8d76380541df6135f61c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1636-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5ceee5737fda8bf87442403196fc4f2ca7c76d2b82f6f6d21f9d4ac43c00cd17"
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
