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
  version "0.5.1087-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1087-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4c8f8ea98a0302e306ed5971b121af57bdc6514095c5b6c145a4f39fcd4b9438"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1087-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b8e314e4ac758c2f8700b4d14a3d5af5ad7fd1b1747fa85290d4c2ad84d793af"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1087-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1c37202afa70290a906a380e61edc9e97a3f6f99dd19794379a7aabb756f9304"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1087-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3099e9e905d38726c131a34d479e8ca5f4de446be1313d3a26fab071faa6966a"
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
