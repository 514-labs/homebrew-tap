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
  version "0.5.1170-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1170-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fa6601f7c94144fd819398f8696de912bd7c78da8f48f6f2f2b577fb1d190099"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1170-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9893dcdc474532c8ba2cf885a2cb121b40db75934ed74dd1b8882439b1f54a58"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1170-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "539f8eff1d9f86b391650455dc1f1e3213ab0efa4f1a7321b90f317424a5f885"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1170-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d2ffc340e07c07673edc0604c431e4d28c11046a22b8191100b72ec7dc23beaf"
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
