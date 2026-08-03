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
  version "0.5.607-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.607-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d2684e4b915bd140c890cda64324e9f7aad3feb449667a38c88e7a1a69207fd4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.607-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a70f0dbe8d838827c6daafccc304dbdd99328a08362c235fece4ecc8030ae78b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.607-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1fd5f73925d45ba0b176c9b9f175bc2af48f9151167ebadbab4bd87aaf1724f1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.607-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "45c0dc21de1e50725fa4ed9ed50001f76ba4354681e3d2f344cad412b07efdc8"
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
