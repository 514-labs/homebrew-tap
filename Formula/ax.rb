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
  version "0.5.573-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.573-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "15045b803bde373e32c398094315f373bfe06c9cd643bbe7593436b1fdf6d651"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.573-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "98da2676a96d27bbee589be4a9c5c6a503999ce742ef46e4d4a279f4f3b6e3dc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.573-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d850f8414d4f22d4ed4927881e0f25af1cf8db4fce509708bb142b841dc4270b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.573-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d13389d27e66cfa130c07801664820c2bdfa662f5544322b45136256bbed9b32"
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
