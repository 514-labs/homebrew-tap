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
  version "0.5.921-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.921-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d204c450af6030cd445d6ea1dd4c4664b64e4b25441adcedaa8ecd407acdda97"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.921-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ae2dbbb4bba7fce46f00b4299618d57035eefeaafb92d2641ced0026ab76d8b4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.921-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1a01f8d1079f2e682d078234120ad11013cbcb2fd084c93a4e3755b95b501065"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.921-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3c2e42036138e824c549dbe20cd57eb29ede9b239f35895cf5b83e9f0ec4d8a8"
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
