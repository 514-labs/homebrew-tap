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
  version "0.5.876-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.876-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "23b2309d8258960799aad5459984c4a223fdff15a6b79442bc198241f417d881"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.876-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0d0bac40566bb8852e9099c88f2125b5e273d5ba185859b5e76db0f4a06d4e53"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.876-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "495476b3412f593f54fb61405ccc0bb4f84f8ed0af2e0abb2481616b239ec63a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.876-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "433f798ff5e25a15252b0b7bb6d7b7d0923751ba803f8d9b80f2f75fe246f755"
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
