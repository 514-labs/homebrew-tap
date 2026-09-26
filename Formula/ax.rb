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
  version "0.5.1149-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1149-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b97c34f056644e1d17d211bc6b40ee0f9cc5487a651371eecbe3cfd68c7b924c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1149-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4cfb65a0261b19ad42dd218d975803d214721d90c527109d6a8d576dfc0f3c9e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1149-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f0bec6fd41ab803180d7bf33242bd7436e6834a3343db7726fedebc4fa25a440"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1149-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "54d7539cea8e9d36de0c746bdf4e446dc66ea433db4ad59ca9cd45af56c572fc"
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
