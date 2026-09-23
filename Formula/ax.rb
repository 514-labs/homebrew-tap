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
  version "0.5.1108-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1108-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "90d870f4a0556628add2054f4539d1315304d517b7abc2f15c327d9052bf97c2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1108-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9af9ddb6638edafc251b843ccc669e8ea88c9a4e16049796871f56ec4ef0b8d3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1108-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a7fad1d89d8b7c2be7ed37b4be95b74aa965773267496c86b4e09acead08df6e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1108-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a2eeb3590bf1cae0ad5a7ea1018b22b9151393be70f740a8a9f952e8ea3e9bca"
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
