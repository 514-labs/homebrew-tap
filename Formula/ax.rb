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
  version "0.5.368-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.368-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e4af61204115ce0351414de368d871ff406ea0c07b2a830d6cea58bf1a2297b3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.368-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "36c978ccc014f38f0bde6b0492ec5e92316682a4eb4bc7ce2c1afb21a2552851"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.368-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bb6b16b92287dee8ca0f24f70066fdce6f5cb66ad17948e115a3ca0647f801c7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.368-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4b803444123d8760582a0668fcdf82f9c5cfb06b798dd4cd67874745554e43ea"
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
