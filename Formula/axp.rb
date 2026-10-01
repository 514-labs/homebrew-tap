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
  version "0.5.1216-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1216-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "18dfc3c245542893f7717429cf0a88ffb03d2ed2b43f2454a7edb00c0f0fb1f1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1216-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b935150343a00dceee3161fa06e383c2f5ea5d1562745aedea6d9900df75de3f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1216-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f9f880fcbf3924db99e77bd2f18aef8ddec8596e998f76ef54792d1003bae885"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1216-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "201da3f758ec1ee91bb599d8c4d14ef13453a62bd23281508e8c636810215967"
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
