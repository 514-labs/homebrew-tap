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
  version "0.5.588-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.588-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3665dadd2398f5eafeffe2fc0d0c83efb416667720180834b5b20c4835c39dd2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.588-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "64ea240ba1c3dfe0979fab327fbfa590032265ca970d935ccf7eb4a9665f79c0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.588-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6503c98d50d9bb75684e1874bf49ca4269bd40b2e55d5438dfbc713a576e2673"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.588-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d7b6af536b03ca22ee8c403f52afa47983c6c6da6c7e51370fbac5c6a2911a37"
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
