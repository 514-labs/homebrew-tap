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
  version "0.5.850-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.850-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e022b248ab8a096cd0ba6c62aff896180a544bcbeea02e9f2ce2873ced1d4852"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.850-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "08d9e9b4dae889d9a9f01b573ea351a84129da5758f8cac9d11c12824ab6441d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.850-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "70fb0757c2b5f6cb3e9e83817429877fb52840ab7dc45d0f1ae00646f5ab775d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.850-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2251d5451a6f52340c22729d722e266c032a4ba843f539134e833de6606fa6be"
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
