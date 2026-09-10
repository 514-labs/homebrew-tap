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
  version "0.5.1010-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1010-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8af019f1aa7b550076f79da3dad4550f07cc7ab1456379d808b7d1e156de04fc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1010-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6f2e8c28407bf48f42cbcf4c9527b149bcffdd746ba910c9c0e48f77b7e5392b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1010-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6f1dd42c927ff3473e180c46fd6746affc69401b91894761dafaab236a72e005"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1010-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4ed47c47eb7df577bd365395b8356dd77fbdfdf2c18dd48347f299dc8f0d8259"
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
