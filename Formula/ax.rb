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
  version "0.5.571-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.571-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "68520390fba47838aefd24d573df280ca504a13c43132ccdf5504770a8d9da03"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.571-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bd160ff54f125d4475fcca7ec6fceb801ccb267ceef5dabaa6f78eda67877d26"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.571-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1379125be6c1e95692572c6da77f69fdf05f665510fe2d01c51046ebc9d9674a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.571-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4556b96ec6539f27da19679b90499795fc131126b2ea36566a4cbb628c3d0716"
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
