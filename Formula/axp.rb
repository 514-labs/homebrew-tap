# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.406-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.406-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c6a34bad0818d455bfc418e1d6dc8f831958a027a79061b1e312a0ff03790380"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.406-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "cf527c203ceb3d00e083e39ca5a0c93c28bef0d334bde1c0cbfd257f7d66692f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.406-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "46a2c468767a904a4a368ecc1a8381c94b4d26fc5c68af45eaba72f51c92bf8d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.406-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "06cafd9d5a3bac759496a7a6bd781279458c1a4512791d4760d0cc9946fb2b59"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
