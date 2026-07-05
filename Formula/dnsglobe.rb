class Dnsglobe < Formula
  desc "Global DNS propagation checker TUI — watch a DNS record propagate across 34 public resolvers worldwide, on a world map in your terminal"
  homepage "https://github.com/514-labs/dnsglobe"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.1.1/dnsglobe-aarch64-apple-darwin.tar.xz"
      sha256 "5b0374775c04575a4b799a26fc22ac3b6c8835233b533c107941e2ae73dc7600"
    end
    if Hardware::CPU.intel?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.1.1/dnsglobe-x86_64-apple-darwin.tar.xz"
      sha256 "c2ec3d63ba00dd28c3baf027f6780eaffcb7c21bdef76a404c326423d2f110f3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.1.1/dnsglobe-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "49fd1b3febf4bc8c0c1c8fb8e6af52793c2a342ec15306a28ae55615bb646f35"
    end
    if Hardware::CPU.intel?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.1.1/dnsglobe-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7f5e54c4964533842cd1ab394f5c8ccf4c74b2bd3a449e8383649ca2ffb1ee96"
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
