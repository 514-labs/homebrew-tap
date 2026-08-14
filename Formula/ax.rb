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
  version "0.5.779-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.779-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "daeab5c65d7c7d6250f74ed65e5d965f829cbda02fa70764f774b11e2c3cd94f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.779-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1145a032e71d8b317c220720768dc68c0dbabd9f0d00cd28dc440ef41ab6ad61"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.779-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5495656a6b5d4738235a2a192b3f5b547222a2d084de3ace6afc692a04ec1168"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.779-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "619cf906621a785e3c5fa4d26385e1accc5519a99dbd856c095e5db57a883d71"
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
