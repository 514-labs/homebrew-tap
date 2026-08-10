# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.723-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.723-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e1d020410ff79372cada1f8a125bcf453c13a5beca7bcd92d96d8476480d03c3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.723-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "47bb3dcf91f3768b57fc7db9292e00f831375fc55f5165c18b994daa8efde46c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.723-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6c878758c7bd1d5a925a268caa5417fba285ba18763fdca184eda16daaaaf596"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.723-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0076a84cc36703994f653c577e59e1b6e705cd302684812fa8cff3cd47ecd61b"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`ax.tar.gz` = `ax` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
