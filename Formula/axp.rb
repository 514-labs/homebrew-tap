# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1723-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1723-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6faeaf397ef0ea6e5eb6b42f0cd2fdac0580f677a217b1c0d75091eed33cb81b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1723-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b91b49bedaef7fb14513486ed78c3bbcb0f54afa5941c70747ce618832ebfe10"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1723-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5131880a7e34a4f38423892a7dd274326a5900417168fbb911de87ee42c36d42"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1723-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2c81b5dc85cb53c039e4670d8bfc333a54f8c7e9c19c14e6545e979dbb36e53f"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`axp.tar.gz`), whose only member is the `axp` executable.
    bin.install "axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
