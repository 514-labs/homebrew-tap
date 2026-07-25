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
  version "0.5.432-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.432-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6b63bad937399dfeb5b9c4aaa5315f3072cc110b0aa360847335824bd934fa2c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.432-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d60953c9abf87a257815e44ae74008baa750243161bb3f36a56d16d06287dacc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.432-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ab3db8764e7d266491a53ee6508739c87a6e7b84fc2161c6a68c320ed45dc084"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.432-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a9d8dcf0b03691f413a4f8b8c6f559f73d4aa63ea30fd10cc548a282a48fd6ea"
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
