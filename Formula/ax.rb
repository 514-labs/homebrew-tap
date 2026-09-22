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
  version "0.5.1090-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1090-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "acede2db82e2ff2ef199d91852054154786309c5608304c9cfdc605edff3dc18"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1090-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3f49c7f637a1914168bbd4188261e906d28914e8772072214c4235dad3cf2c9d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1090-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b1d2ee8e59090a171e40e5ae9c6a880f20cd046cc166e10f01e71694bd46d114"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1090-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c5de687629dcfcf53a9ea15a385139e2ade921f7476b5210cb97392b67d7d755"
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
