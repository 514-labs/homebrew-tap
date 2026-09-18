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
  version "0.5.1076-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1076-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e9f691180ce41e13b798eb453c6522ee5326f7d3cf96a974efcdbbed5bc6fbdd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1076-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a4162a73496a17ce8f2d7cb98e7b09661e8e70459d6905c93713d7329595ed2f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1076-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "956d62e0a818fcfba722a68b6779c70d0452c266da5d342aab3ae5a23f5630d1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1076-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fd3c0e1b8ef07dcdb0660a7c7c8a8e73bbb19fc811b67205cab77a4660fea630"
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
