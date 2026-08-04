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
  version "0.5.629-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.629-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a87469c593c6fdba107307db8be984943c2f590fe932a11d8966b19d48224f8d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.629-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f8eeb3911c86bff0a2e35506f2c43bc7acb262d93a36829fe827e00280a33bab"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.629-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0cffade2a9ea6cf5c314c7d7d405ca35f6b2e25a0ac6d29c7d32152888fa2ee1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.629-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7a84cf970785d3ad7981d31aaec6fed55b98afe70dded4829ac8ff84c8546020"
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
