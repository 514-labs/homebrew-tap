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
  version "0.5.645-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.645-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e6236e8225e5a864bb7bc430711638687a469364fa2eec596fd582e8d047ec79"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.645-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "43d592a8ebdb1cd9695c3562b18d713ff6bff47b589586ad0fe213c37492918b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.645-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "82afd57a1cff600a2f0b8e462ecbb98485b78c1b975eaf2aaba826ad4819788c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.645-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "96a100323a7dffc5f29225f9610e4f7ea3b06568ce40123b1e04ff63a6a54313"
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
