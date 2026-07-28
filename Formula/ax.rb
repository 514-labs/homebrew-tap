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
  version "0.5.506-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.506-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d3bcb4f01a988a17e1099d4088d25dc7ae4229160d091f1673dea89c03d13971"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.506-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "876d7d60852de866f2fc838a8d1262e82b8c5fa49a13552cfeba31e8a5f28e66"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.506-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "413ac382c2782ff7cb39cb2046a418ed0218b241d1082215199e4f3f51886321"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.506-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3d090c4ee1a73c08aac2e8355cca82cd8284499cd095e4b278e566386717816f"
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

      Create and run an experiment:
          ax experiment create my-experiment --template cli-install   # your agent writes the YAML from your product description
        → ax experiment validate ./my-experiment.yaml
        → ax experiment run ./my-experiment.yaml                      # smoke: 1 repeat per variant; scale with --repeat 5
        → ax experiment query <exp-id from run output> --metric testPassRate
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
