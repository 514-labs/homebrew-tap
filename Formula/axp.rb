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
  version "0.5.616-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.616-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9889c8ed544cb2b4596c7ed2441fcc927b6aa132a7a6439c9c3bafe0feeca1dd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.616-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "6aa2af59b1827463ee349c538227ad26c08330f7613137238869430c04ef1852"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.616-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "da9da66e39ae60573a008ed77aa6e27a02170d48990da5dc8d811f66159a7401"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.616-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a0cc8b8650e9c9692b61f9f10b40dd787f8893c4ffc1457d97ba95ecc6759399"
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
