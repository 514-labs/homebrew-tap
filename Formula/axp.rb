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
  version "0.5.1215-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1215-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "890cb172b7299a450d929578dbc23b98fb8e7a53a0c6bff211b2e80522d55099"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1215-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "db3914984fff19438a75bb890df1248973f7dbb5169c354f641713c26a8da7e1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1215-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "589963d6408799565b58bd6765d90ee2b4022e4a9cbfdb16b744dafc03ce823f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1215-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "dfd18673342e6846ac631fc27eb11be6d66d70076c327daf70dbb0fd50068784"
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
