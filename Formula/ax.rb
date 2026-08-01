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
  version "0.5.590-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.590-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "59d1ae9dfe652c2237a08a2bb1627b6ec9227c563541a07b8e3632cd3476aa73"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.590-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "39c8abeccb25205e2491f9fe6e6a2671fd243ba166c10e29e45cb19ba3b92304"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.590-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9fe92f4da4f67464af8e1fd8a4546b1eae88905bd392dd859244abe55c478892"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.590-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "13ca25927859e928be1478891dc475fe2bb80710bab01e374eed1ccbf307f85b"
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
