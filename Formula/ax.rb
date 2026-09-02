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
  version "0.5.948-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.948-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "830f9742f4d4ac8adb525107956c7c08093523ff9b790a1b71a2fbffb6183d10"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.948-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0d9da3f1fce4175eefe2ef439fc84f73e112f77b25c9522ca3e779837527bda0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.948-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e6eb5a2c1f24f93b7d9a497b7c511a7a061dad075aed2617d222901b2dc0b3a0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.948-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "91a595d629efb612561923e2816260312bf03a47a4e99327d66eec9ba6a36cc7"
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
