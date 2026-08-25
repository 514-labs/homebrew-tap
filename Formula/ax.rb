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
  version "0.5.870-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.870-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f3735d7f4bb8130d0eb90732f1533d4c7b1f797b567dadc8ff094ecc97cf5b08"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.870-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "704ff82de3954c4e931b7ac309d70dedb5a9ab83f25570dd1a5c80b7b1bdcff5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.870-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2e74c6c6d624d139fe4ec46616022ed0eee6eafeda71c2bfee7ea1533216e8e9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.870-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2cf8cc7914e7f2076f8e1fd4e380b6527c07d9d6216836896f02cb45865a0443"
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
