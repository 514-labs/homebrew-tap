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
  version "0.5.799-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.799-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ecba07f68007cb43272c40d4642a63291724862c773f8348cd65dda290410128"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.799-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3671f15b7b0c8194e5e64dcf60eb571cc71e2dedab82d78d0464838c081c9a34"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.799-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6581f035d9fb7d7916b8e03d5d3ad50fb4f475ae4332626568893280c47f724f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.799-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4917304bf83ee6c952a20444dee7fb1723b3fc035eb311e68959abbaca763baa"
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
