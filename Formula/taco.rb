class Taco < Formula
  desc "Normalize all your commands by wrapping them in a taco"
  homepage "https://github.com/RobinMalfait/taco"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RobinMalfait/taco/releases/download/v0.1.1/taco-aarch64-apple-darwin.tar.xz"
      sha256 "baa044d1b7441d1607d5e82104a6a4341a0b845037cdbaf97f60ed36b84b7e84"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RobinMalfait/taco/releases/download/v0.1.1/taco-x86_64-apple-darwin.tar.xz"
      sha256 "e0b7878f6125c79ede31eed6af1d14d632e805f232585eed1144298a4db748fc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RobinMalfait/taco/releases/download/v0.1.1/taco-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "716af812c32f91482748646443aaa45e562c850e21f381122fe301697d85bc48"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RobinMalfait/taco/releases/download/v0.1.1/taco-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "857d3056f944d7d5392081d5be433dbc74e733472d27f0c06eb1252e6134d460"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "taco"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "taco"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "taco"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "taco"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
