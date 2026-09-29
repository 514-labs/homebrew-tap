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
  version "0.5.1166-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1166-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "17890dfb1e2751414c5beba5f05155f3fc151203367b1b9249529e684977fa76"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1166-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c765a143949d02076c89241cc14320328fedf875ade366a5f8c69f66cd2fc193"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1166-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "eb422426663c95ab6bf577e11cf235536c45bdda22ce33d1549f444932e8dd32"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1166-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fd29498dee8afecb32a47a2165cee63905e68ae6f195e7dc0bfec5e559fa5d42"
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

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
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
