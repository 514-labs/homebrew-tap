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
  version "0.5.673-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.673-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "963b793f1067eddf6de424ffa9bc5f2e79f11aa4696dbeaac2d7b69bb4efcd77"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.673-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4427479247131e24810bfc4a3ca788f96018fee95e43c85b8e25da3780fc4f06"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.673-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "763d97945a6948c2179188b81853ac12757cc2a448de423a628304ff6026b13a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.673-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5494ada39748fbba4b1b7cc385e988227c7b6b0de89daac5c1b6b0a2067dabea"
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
