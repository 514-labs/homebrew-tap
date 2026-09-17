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
  version "0.5.1067-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1067-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "37118b64652c78f8c9fbf3310a2862c646919664a230c02ca690eaf8dbc3cc26"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1067-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3507e0c0c47764e28b83bd6da1e1fa7c414de5709681f62d48161062ed511da5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1067-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "39841f07db4ce39620d57db3c48c7004707b8aad228b81a44069fd194a9310af"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1067-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "37e5d3fe43a823f3f3826a4f0ad906360d89db14a09ce6bd39dff8f1d2db476f"
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
