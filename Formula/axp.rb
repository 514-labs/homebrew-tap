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
  version "0.5.1224-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1224-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "84ff79d86c073bd9388ccdb0222d08b929eaa388bb4686723a27868f11d50efa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1224-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "520284d5ea8fb6ccf8225695c6cc128536e0661159e1a0d26a441c99612b7455"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1224-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5a0f9145152cc0f08756dee53e56496ea4eeebfe143b9de12b6e05d62c768425"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1224-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "80aa884aa79758cd52b5c127dfefc4dd0f0d458b43d57664147ef9fef95f0212"
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
