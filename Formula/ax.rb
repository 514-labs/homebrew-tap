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
  version "0.5.988-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.988-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f0e28de1572417665610a7340f6064984a4b1234694f638fc85c76c99440fd16"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.988-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "cf0a04e0423e9169fce9cee0ca6d818c186567bebce350bb23dbda821e30a1c0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.988-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a6abfd51fddf59a6fec613acd6e67af7f62f4d17dc81c738309a0bfa0618d32c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.988-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b9ca238229a2823b838a4514a6dbfbf9020e3f6c21162c1114d05cbbfc4b4a68"
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
