class Et < Formula
  desc "Remote terminal with IP roaming"
  homepage "https://mistertea.github.io/EternalTCP/"
  url "https://github.com/MisterTea/EternalTCP/archive/v1.0.3.tar.gz"
  version "1.0.3"
  sha256 "d9d1dd713eec687b1e808f2c965e8ba3110dc5e2a4abea5e01d5ed6382da4379"

  depends_on "cmake" => :build

  depends_on "protobuf"
  depends_on "libgcrypt"
  depends_on "glog"
  depends_on "gflags"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/et", "--help"
  end
end
