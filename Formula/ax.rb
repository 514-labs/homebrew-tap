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
  version "0.5.578-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.578-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "831637ffb640bad146f70d461e49cf7fbc31ea17c8351f8302ad8f56c18d1fa3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.578-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0c512f090ac2fae35f259af230bcaf4e7af9a8b457f5a5eb15d8004e820fdc10"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.578-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "de8110d6d725e671acc23a0bc5c2ae1be369ce9acd57472a75b40df13f634375"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.578-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0f83b9c7eaf764f56907b95cd89a044b3da9fdd09a1c040311b1bcb503872c43"
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
