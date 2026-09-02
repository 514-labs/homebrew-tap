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
  version "0.5.950-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.950-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6bd7376d8e12d83285b8223d8d14347dd46d613b32c6b75c2742d1644e870430"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.950-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "40648f73e7a52f3e5988040a6b675a1819cdcff4a8d7571d37645b454a6a5bf3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.950-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bd20b081f1f3eeefc75542c7aa7bd391ccd5b1ed9cac0ab737c2b6c6cb9d3e4c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.950-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c168ad53fb1c4c5699e72b518b519cf73ea03bc82d72fd4e92eed859e748f7d6"
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
