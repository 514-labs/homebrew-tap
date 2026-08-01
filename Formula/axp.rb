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
  version "0.5.576-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.576-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5b3fd5bd91a613c7662b82f76f7cfe2d298c6f1c60dca2885bc5d479b7b71218"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.576-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "457cf4c30402a7c06f45f7a1d9f940c17169cb395916a41c2adaf845a33f6516"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.576-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9db2dea572bf21e72f23e2ae491b417e1be6a455a6ed6ee85baf259533823278"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.576-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cd250bbf11d1b3c902ea57c7abdc158ffdbab5d6b294d39657b971f43c1c5f85"
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

      Next: walk your first experiment with `ax learn quickstart`

      Already have experiments? `ax experiment list`
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
