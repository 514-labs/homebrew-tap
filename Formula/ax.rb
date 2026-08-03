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
  version "0.5.600-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.600-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fc6db608baa4eab2198eb06ee3a2684ffcd2e40be69c7b4d45c8517f68edf9e4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.600-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3a86bd0bac2c6a27db1b823e188266df0371e52f0761baefbc3146d03a7dfe5a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.600-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "62db1ed325cafce4ce5d04df53d2eeb00548a3bb536dd220d99cfeac34a32408"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.600-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "86fbb05fe34af48a5bb539d24d7629486d1ba0ee4df7468d6e63dd1ffc22aaec"
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

      Next: walk your first experiment with `ax learn quickstart`

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
