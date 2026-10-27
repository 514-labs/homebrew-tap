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
  version "0.5.1501-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1501-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "19dda9ec35799c9ed20881f538e612788011818e34d01e4d411bccd3c9224eb8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1501-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f417b8a7db588ad70849bb0e95dde2dc746146f998f4a2ba607d3af4e14175fd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1501-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e933a587bdf4115066df2e84a9cd7272a31bf45e3c3013b80d0fb656ff2b0557"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1501-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1d7a96d0e358362b3290dcb7ec6e3cd358136de09db1c56a476840532f88955f"
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
