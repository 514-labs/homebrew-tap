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
  version "0.5.909-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.909-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6d537de81b3a72e8d1f80936b6591721afa868cb468faf50f87c8c467ac10c89"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.909-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5e6f62592aa5ef5167918c7995db15ed33fd990d7b503996f0f2601e3935dd98"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.909-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0f64b86e691a379b260eebeb7b02e4235c676b98fa5e943a8ab69919e42b6e3b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.909-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1e2b5d9381a9b69f2b233d7c5fee5777c0033c2b28575ee067763c1396836df6"
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
