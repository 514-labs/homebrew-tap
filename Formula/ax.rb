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
  version "0.5.868-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.868-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c179edcce80035456a39b56a04627762997eb673460195854c388e1c1da153f6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.868-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3d7a49093154fd376ea8f24f0c6d9af0973b1c347cbc162c92dcbbbd91a64f93"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.868-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "57b544e2769f8d727dbabcf3501ec56d53a15d7af7e2d9f428ff321531b329ae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.868-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6a48872d3a919ada861ffcb347b9e13133dab624ddaaaa12d6761945bab7a6ce"
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
