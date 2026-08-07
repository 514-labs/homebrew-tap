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
  version "0.5.697-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.697-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "45a3338c8dcd24bb6cd5ec72ac9f3d6018006730a9eb84242acb56bcfa6cc6da"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.697-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "beda3c32d8a85eb139937564977b9460e6fd599353970eb159f3045a0ed0574c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.697-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d841421feed9e1cb0c8d8421b19208e46e89e506b70094b08e21d1ce5f98f898"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.697-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e6ba5ef702ec33efde3a7fc074e91eabfe1195a5a66bf076c54e85f67a93b221"
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
