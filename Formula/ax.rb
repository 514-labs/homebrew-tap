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
  version "0.5.1362-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1362-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6cc58f5a379c28decba989bf055b847918207ba40bc175b2b88eeae7f68447c4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1362-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5ffde9c0ec3a5769bde5d774cba87e77e418b997356df330e351df91c63cda80"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1362-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "deb36ae533270c1bb2010f889e18e9c44a404d9e95a1e3ad514eaa4279701335"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1362-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f204c982f0d856bfe46fe7d814a9fc949b2d54a68e2d0ade04782ba972ab2ebf"
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
