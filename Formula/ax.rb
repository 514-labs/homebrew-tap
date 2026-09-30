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
  version "0.5.1190-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1190-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ba3513698dc8329cc8db56673f03282258d083e1bae71dfa56f29243e85fa005"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1190-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "79dcaf9295c3451b63afc57b89d6e45a6161357e29907122b61973ab6d5fe7d6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1190-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "658767a70b64986f8072a34f8753a7b485a02ee504c7a8b5c62e8e88a8b6f0ba"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1190-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f0932007c49278dcf9e775b2f26089ec4f403fbba4e749ef996070d64dd1478d"
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
