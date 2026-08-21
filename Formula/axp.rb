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
  version "0.5.842-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.842-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "3a49fed8b6695d650641ce85015356edf8bec476c4cf6443d47ceb3eb320ee27"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.842-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "59c724a8f1f1b3d5ed5802f6a55d0c7be601c92a50f34fe3a78397b6507b8734"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.842-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ba10ce533af476fac912d88a1dc78f0e8d8647a5b3ba503a51891ab6d66256f3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.842-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4c704d47119284c799a6b9ce62dfc58c22532c4f2313c3b883f694933c2ed87d"
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
