class Dnsglobe < Formula
  desc "Global DNS propagation checker TUI — watch a DNS record propagate across 34 public resolvers worldwide, on a world map in your terminal"
  homepage "https://github.com/514-labs/dnsglobe"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.3.1/dnsglobe-aarch64-apple-darwin.tar.xz"
      sha256 "686d4caa66bd13fb673558b35459aeb11081e13c1f2a0b714fca63298709a1da"
    end
    if Hardware::CPU.intel?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.3.1/dnsglobe-x86_64-apple-darwin.tar.xz"
      sha256 "e505c9d3bccff0dfd3ffc0c51e84b27b860d7d20329909b117c2e133aa4a763c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.3.1/dnsglobe-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9700796e52137cddd442c5e596f3fd528b8daf3bec9e00684cc5d3d41fc54efd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.3.1/dnsglobe-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8511dacc76ffb3e6da82d1ae50131b334d4cd220c658956e7e88627456d30fd4"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "dnsglobe" if OS.mac? && Hardware::CPU.arm?
    bin.install "dnsglobe" if OS.mac? && Hardware::CPU.intel?
    bin.install "dnsglobe" if OS.linux? && Hardware::CPU.arm?
    bin.install "dnsglobe" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
