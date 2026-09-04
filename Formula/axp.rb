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
  version "0.5.958-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.958-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6db37447b96e7b43241c69a211efbb9ed326d1111165d2ef644cad29339b90f7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.958-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1334874ec5678b7443c1ef35de91d5744507a0ebebf333dd57defcf5a76e57c8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.958-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f35b7a42bc7e4662ddfd337505d94b43f176fb85da1ae388194993657f7e7c4b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.958-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "82c85ac6ef37c3529ead93f3bf218567ed90c182a463df84f8a51e493045d0aa"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
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
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
