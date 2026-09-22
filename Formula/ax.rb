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
  version "0.5.1082-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1082-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0eaa403641359c1a270b031eabcc44d8e03d59c18aff55debf56927c19cc328b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1082-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6b27bfc7a0c33b4806007868f562001e0d9bd04ecbc347b48684b582832fff4c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1082-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9c3618358f20de8d116851ccaac6cd5d4c6bb9fa54d7ef2df497d8108ffe1abf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1082-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2a34fe8f413cc5547e1981472af05ade309a91e38e162e9b0ff5f1951fd0f0f5"
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
