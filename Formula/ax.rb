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
  version "0.5.827-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.827-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b8b5963620b56f42d3f401c05cccc32f1d43a44c0d8c5b5f4d10bc567c3c5c0d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.827-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ef5143df039267bfc0da5482af57f1d91fd6ba04a500c54de4b366a3c1cba985"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.827-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e46d4cb5e20b6e6381bcdf255f0e17f3f9fa1a8e8b1c5a55b4fd3018490ff8ee"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.827-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e0ce8ad31ef762f7e69b93f146c78f72096cf22c59eb3184b3484d5085f3d1f0"
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
