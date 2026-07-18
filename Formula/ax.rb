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
  version "0.5.280-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.280-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b96f9b8896b02944e8d1e7757106b9d92c522d760395ede956808ca942a8150e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.280-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9ff500d3eb32554ee6c30e65dbfd504f64d48b2270014068a4942a4c09ba1235"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.280-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "eea77c2187d5bcb52add226a107b93e6536a3a8f862bb8896e5ac39159c2a65b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.280-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d11924642f89c8e8c823550ae3cbd59ab412a1869791cc99368f427ae1e7458a"
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

      Create and run your first experiment:
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
