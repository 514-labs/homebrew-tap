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
  version "0.5.558-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.558-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "39c8ed7f0b8bb9c0f2fc2b67a53f482fca04410b25b2d00c33669936d3f20166"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.558-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1ed7bd5b3cebbc08f78321cfd11a83d99d0f34fe16ee2f09efd255d34960d555"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.558-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bb44c875bef520f41d6d47d9e222b2aaac406ed2d3ff02a2a9be823d47b481f7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.558-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "672468d941646c9f72222c0ed178fe6185bf5a864b57febcf26c3caf65a8e95b"
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
