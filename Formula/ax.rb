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
  version "0.5.567-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.567-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4787a36f87d8aa3e6dbd4f7f6fab3757bff142ebd89487c2956360a3b308f2b2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.567-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9ff50bb6eab16ae771649385a437351ff5042e7dc7886df3ceeaea26d6ac2400"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.567-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fc32e164112e879868e73913e53f4009ad1f510aadb629b842b3d2a15fe535d6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.567-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4fc173b5ac41a2b14befec932d75a0ffdd97265417b55c8c714f2a42bb0a5387"
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
