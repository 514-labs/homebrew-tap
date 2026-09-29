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
  version "0.5.1171-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1171-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "346fbffab830f09578811fb616f89ad6e8cbdbe556fd6d8e6669429c010d251f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1171-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "59ece995d0f8bf60d2ae51e0ca1dd4efe5fd4c17115b8b4ecc3aa11789a710df"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1171-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0f4f8b60bb701220acb20689b40ea23652eb1b9cda38fcf62bbee90224cecab1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1171-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "dd6784e6a2b93095e959821c066fa768de79f3a7329b588996f73fe0cb78c6f2"
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
