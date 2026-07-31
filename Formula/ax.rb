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
  version "0.5.557-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.557-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b91d608f666df7a8fd5ba1f953f4c21c84c49461ebf2ba1fe421410f01146799"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.557-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "20e17e3e72121aa18a32e1fd506b3bd860640f6ec5b6ed5f66c129e51af8e412"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.557-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "41b51301826302b3cac8f5f1e676082ffb2d192a8f106ecc40d77d618d122cb8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.557-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1368be10e9aac600665a0c8bff045cfda6d0e2d9c5340232a7b4a58095f7a94b"
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

      Next: walk your first experiment with `ax learn quickstart`

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
