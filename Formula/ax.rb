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
  version "0.5.664-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.664-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "567acf0336f3c6de25e2c598e1b7ba435220cefd80723efc73a34427e42929cc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.664-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "84a909599a76c69c3c8a468d3a6d871fbf997e2e599274bfbfe86f2a1a44e8c0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.664-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "786ddf0f6ea7ff3eef3b5b9f850efcd61b16eefcf6504264408a9dd60c7f0429"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.664-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6c6e8d0d9be4d92535d8fd41e28bc7309ca87bd675016acb4bf8bb1b1bbd300a"
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
