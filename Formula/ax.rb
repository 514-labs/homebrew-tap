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
  version "0.5.985-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.985-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9acd9c0cd5cdd43c62f3328c1acb9ebe5f67354a3d288374be3087807984b3e1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.985-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "648a8c909b5c512eecd6af43c81f33c61b31c41c482dc9bf2cb9ac579c6f1548"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.985-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f47cdb38e1016ec2816c39fefff330db6909e9f71043f870d30b35829d40f562"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.985-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9197d1fc52ddf027e1bd3b064fcb864444d8c266357eabf8f32d7e65e774857b"
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
