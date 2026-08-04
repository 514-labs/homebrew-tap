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
  version "0.5.627-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.627-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "314248d3f2a5bbc7968695b7b4e70cb697c70b2c4073f9c0ade83afc20b84175"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.627-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3acf4c9ef087f4408ddfb11152f00200efdf2b7d9d03b2636f0b821293b74288"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.627-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3f5a50b86fe1869d25043ec0353334c63829d9915a8c8442891eb791005a4c64"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.627-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2d8ba76658d39430a98d14abeadcb079c9e23996b999c2abca7e4a99947940c6"
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
