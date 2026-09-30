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
  version "0.5.1183-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1183-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "fda209d84aacbd36e585ad79822cac4f408d4205daaaf1f0fe80eabc0a9504b6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1183-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "21d63c0eb5fa616499dead42baaef22cd1db3a9d2a923c391701003e5bec1958"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1183-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3ddeeff405b2e3c219b40ebc42e04a1eebca84586a3532f16563d47100f6b4b7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1183-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a12066b3683ec80b774fa76c46cc0edefd8308ef1d26ede322a9eece16815a07"
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
