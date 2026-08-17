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
  version "0.5.816-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.816-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8282680353ee7c1d7b58a558af7faab277d61b13ba7ef57acc9aa045c2fddeba"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.816-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "47dcc9864d29e78d072689150c879f06039a13335a0498c1b8e87f0b215306c6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.816-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6a6b4e2e7b28f30b7660d97cbeb296011979f7c41404c23fdc8234dabc69720c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.816-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b5c0653eb4ea3c3a59fd4352071cf54c6f513c2202931a4d47e3b2c67d28b369"
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
