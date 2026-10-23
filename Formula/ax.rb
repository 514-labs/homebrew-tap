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
  version "0.5.1473-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1473-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "572c245a4716105bfc0465c05149b8c692411f260e54a4f0f706e0c01b53a116"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1473-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "57a8307fc0ac82a169b51603bccd07e5b41773507d17609a2390b823f9ce869f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1473-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "57af4d63254f363628eb5420353dda22f587101dabd6af9579d6e525976c63e5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1473-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "57711e2a9ad133080ff83a570ec06735996d0eec95e69cc2080e77855a150f7a"
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
