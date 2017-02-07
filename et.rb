class Et < Formula
  desc "Remote terminal with IP roaming"
  homepage "https://mistertea.github.io/EternalTCP/"
  url "https://github.com/MisterTea/EternalTCP/archive/v1.0.4.tar.gz"
  version "1.0.4"
  sha256 "554df4d3ab618b7c8db1ae903b6a13293b02b6a6b98a27f94b7254ca170c9f9d"

  depends_on "cmake" => :build

  depends_on "protobuf"
  depends_on "libgcrypt"
  depends_on "glog"
  depends_on "gflags"
  depends_on "boost"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/et", "--help"
  end
end
