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
  version "0.5.901-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.901-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7884847d0c93908898442d91ed0ed3012d491f1d888e3245e8cb45273849e74a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.901-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "fa0575cce357da87ce45fede8c14ea2ba85a3e35f1baee9d5d6ea5aeba87038f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.901-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "85605aa76403563875b064c99a3b8d6a4342028ea1c18d8ae995f4bd771d11e1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.901-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b3538b611a609267728cc7b675339f42ec11eeecddce11c399ec8d63231948a2"
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
