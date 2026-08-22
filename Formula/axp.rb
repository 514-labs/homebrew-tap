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
  version "0.5.843-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.843-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b5ca2d5935ff7e9a402070598cd0eb7b7f898f70bc4be73e14966034992a03f2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.843-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "29c05b1824010c0ddc5970a597da485ee68716dc47ff4b19ee02c0161c8d075c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.843-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "518343afc7adc5a4416c38075b1ca902c7a267f853ee00bdaee1e0dedd944da9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.843-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3e6eb7cf2962b60d0de57246991f68301a99002819e224217381cd620c6fb8ee"
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
