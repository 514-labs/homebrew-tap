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
  version "0.5.621-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.621-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "1f97d724bd49552a0e765aff1b7262204f32f6fa8063a01c2513bf28f2dd2289"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.621-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9c70d9b93dbf2de6b04dd5d1f16f80d23c8c7ec1682139c0cd3409f1284de0a8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.621-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a67f8e3f6933a6ff55a36de2c4e61b26b9b1fb00cf06baa9a476755500c0544a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.621-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "786f24b0b210fafedbd6fb7415d51e344427e6f3d09e6b04155110f3ca49c10c"
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
