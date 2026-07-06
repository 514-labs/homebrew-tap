class Dnsglobe < Formula
  desc "Global DNS propagation checker TUI — watch a DNS record propagate across 34 public resolvers worldwide, on a world map in your terminal"
  homepage "https://github.com/514-labs/dnsglobe"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.2.0/dnsglobe-aarch64-apple-darwin.tar.xz"
      sha256 "5b2c0c7a8219dbd43d98df93091c91609893778bb88b169142be416cc142a3e9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.2.0/dnsglobe-x86_64-apple-darwin.tar.xz"
      sha256 "92804a63bbdd02700d2915f3abd084c1f0328cc409801912a86e8eda470293ea"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.2.0/dnsglobe-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1311a3dc605c03fa9b56fff6aafa9d12f417bc3e3662b6958388713e778fd080"
    end
    if Hardware::CPU.intel?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.2.0/dnsglobe-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "78e2c0f09f1e3eb5395817276d97ddf0b80f35a5b7cfc4733ce59c6dbb8f7193"
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
