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
  version "0.5.598-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.598-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2c163c30542f107e767c18eb4bbb6fbe03a2ebbeec25ff2022971a2eff609b9f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.598-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3e8e491a9e5192cd64a7f1b1a0f641491564b3cbe72d7772ca3193c520920278"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.598-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fd5530b69a5615b8f1c52758baa32b055162eda48bc1d0ba5ebe9033ad103ad5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.598-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "738a2f8637c61e838709d6a7da64827d53c3d6a2deb2eb80d45e9b95c20ea12d"
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
