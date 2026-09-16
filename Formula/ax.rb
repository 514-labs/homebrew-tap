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
  version "0.5.1060-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1060-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4c41ef6ef3f09585e9db84a1175fa82581eb200ee6c12481f2853031adfad691"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1060-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a730d3c3761cb0bf4ca8e17aaff3a5e8ee7793ca84f7b746cbe4c84745296638"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1060-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f35050691d1a8aa4c0f5eae80f9c9bb8dc5989bc5cae9f0150e82249784b76c4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1060-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2b194a5debec448563d6dcddc571db3472410074d1ac5d0e2b7381fb1636464e"
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
