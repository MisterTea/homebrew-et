class Et < Formula
  desc "Remote terminal with IP roaming"
  homepage "https://mistertea.github.io/EternalTCP/"
  url "https://github.com/MisterTea/EternalTCP/archive/v1.0.2.tar.gz"
  version "1.0.2"
  sha256 "c5e6ebbb73722d49607dfb6026a93fc8f6c3891b3df9e0bb55be84c921ed5bc1"

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
