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
  version "0.5.617-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.617-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d935acc8e5c63a3af929697067e5f824042afa3b2035fca7581fce0ff0221719"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.617-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "850594ca112d0f23c1bfcc36d6f31cf98c4454e8c8dd05f8f70aa0f8446005aa"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.617-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e3e308046b3e23537381a2727f82bc42821ee07960a6b908882ca5c27f30772b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.617-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6166d963b7fa798a2e1bb41bb81ec0b944788e0601dd96b017134d4e1402b99e"
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

      Next: walk your first experiment with `ax learn quickstart`

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
