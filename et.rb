class Et < Formula
  desc "Remote terminal with IP roaming"
  homepage "https://mistertea.github.io/EternalTCP/"
  url "https://github.com/MisterTea/EternalTCP/archive/v1.1.0.tar.gz"
  version "1.1.0"
  sha256 "8e7569576a8a9507db67df08dc0b65648ba5868d1e10ced332706797fc7b7f8c"

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
