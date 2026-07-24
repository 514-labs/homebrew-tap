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
  version "0.5.407-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.407-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "143a7ed03a8d9ad69c04c765972b7ec64491ea4a25e554f5002a50bba6967e11"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.407-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d241770bcc93fcf0868935f15909864fb4517d8b7d6a5b9c32d32c7da927bc6b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.407-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ef6114cc7275263c11ad07c6d71e7ad0a2a4bad7ad2b1929dcfc222003e05276"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.407-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "42dc7646ad28a6669f0cb24d9ae803e9a3b3ecb7aa365fe6048564e55e3f63c8"
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
