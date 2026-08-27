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
  version "0.5.908-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.908-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8c83a410fc7dbf57b9e0902cbe46e27db08a4c18c7643b9fb8f4b1dbd98f0b9b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.908-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2cab1b49a8e448eb44008373b22dec0cc6178f91bb61b92463d541a86c435b15"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.908-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "20472b817d85bfa42513378eac15131140b1c2e234f14123666070976bc59155"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.908-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ed326576d34a3b1af1f223340e57d7ae2ca18154430a4ad7cf75e34308d28363"
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
