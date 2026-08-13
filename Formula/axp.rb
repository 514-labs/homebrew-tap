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
  version "0.5.762-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.762-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f73a7614c347af64e6999d4d165bac048ff978d13211db8019ffb64ab6f95744"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.762-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b0618b63a3e0736af81388fecc35d6d60bd8c9035de524a3a48f0c3692ad2f22"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.762-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2908ea419f675a5559bc46b69e94eada19ed012574b6f3e3d0209d403a56f27c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.762-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b35460824577e1878f9e16d6a0c33f8cf5b196f84b982d27fdf4718eefa371a2"
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
