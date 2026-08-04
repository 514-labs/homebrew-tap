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
  version "0.5.631-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.631-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "00c9cdbd10d2cc87d08db5c220f5693a3deb8b8129e49435f3e8f5fb583c82ce"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.631-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "43039b2888456aac9eb010a4461e92dcaa25eabbbccda9296665830982b9f98d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.631-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "eab76b8c1012a1dabc5c14aa1d6a05c36eb4b5858e32ffb0abb79fc8df79ecc9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.631-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b56b06685b5a7bd57cd69c1a64e5c4502cda58ec56cea7531e978d985f0a08a1"
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
