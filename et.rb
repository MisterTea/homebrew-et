class Et < Formula
  desc "Remote terminal with IP roaming"
  homepage "https://mistertea.github.io/EternalTCP/"
  url "https://github.com/MisterTea/EternalTCP/archive/v1.0.1.tar.gz"
  version "1.0.1"
  sha256 "594b182a33ed8edd80b27b87266d400d307a7c599ca41a5d851d5fc2c898c105"

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
