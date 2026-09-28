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
  version "0.5.1161-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1161-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "cd51bd840dc06605d95dca89504efb3f02cd7db22472c048aae33d8a3556f71a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1161-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "78ef1068cc42e7c3f1694f69bba334d9a9ab304b20f67afe26fc155d79dc4e7e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1161-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a19033b305f2509883e91d91441e889e2fb957f46889ff7ff26cfe50e4a43f59"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1161-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7923cb5b7e0b47b6e153a358bbc060b5cc0aba7eb48c2ae774fd912ef6435750"
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
