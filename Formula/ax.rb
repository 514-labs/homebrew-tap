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
  version "0.5.647-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.647-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a93824e7e57489943347d5a7a5a313214bbbb117578d042b5a2590bbf162000a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.647-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f3e9d437f9705631091356d6a42fdaee5d71f3375c92261087af8b1ef8e50c3c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.647-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "55b9afd000025f638007f090510d6aba803b18985b07dfd3aa42de77f1681bc8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.647-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1e6953159ab8af005e44b317ec23380487156eccc275bf9d37bc6b6fb25422cf"
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
