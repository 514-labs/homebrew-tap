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
  version "0.5.654-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.654-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "feee080aa3fd287f7b7f2ccd5044d98472dd510008c3ee27045cadba1fa07de5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.654-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "8b5db2dd86296fc49445e72ff220c8c211f05234ae94f490ab6cf10fda5c59ca"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.654-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0f76616dbd13a9cac2abff880d54c5a8896b122756409d927a23f260ef93e7fe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.654-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f24f2826cb89f3d13ae7492125d0b5d2310a623167e354744aca5b294e5312f2"
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
