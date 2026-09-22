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
  version "0.5.1095-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1095-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c0489347643eff771960932a47bf179955b7b05872090cfbff4379caf4a8b132"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1095-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e96d7c196591b3af3efbf0a9fa719f2ce663336bf06072d254f6a18be9a6e041"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1095-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "89b61727734dfe59dee72f6a753fd7a47bfc75dec774ec9f65476077dbcaa161"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1095-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c74b3db13b19977c12efca8d1374eea4a6bb57fce69e5898a66ee076373ffb64"
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
