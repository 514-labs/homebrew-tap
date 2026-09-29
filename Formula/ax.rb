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
  version "0.5.1182-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1182-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6310ca305e6132436364c7afc281ff935277effebd0229456b55868f7eb64a6b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1182-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f82af559ec05f1189edadf6329ae098f05c2f7a262f073290828763c1323499e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1182-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bc14f47a271b22d21d8189dde9f8c34c384e09e427e238dcf7c3fb2c5ea1c7f3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1182-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4bfbd04d48f0e67a738499422aa161944b8ebc2011973f97e32470a0ffc616ae"
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
