class Et < Formula
  desc "Remote terminal with IP roaming"
  homepage "https://mistertea.github.io/EternalTerminal/"
  url "https://github.com/MisterTea/EternalTerminal/archive/et-v6.2.11.tar.gz"
  head "https://github.com/MisterTea/EternalTerminal.git"
  version "6.2.11"
  sha256 "e8e80800babc026be610d50d402a8ecbdfbd39e130d1cfeb51fb102c1ad63b0f"
  revision 2

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  depends_on "curl"
  depends_on "openssl"
  depends_on "protobuf"
  depends_on "libsodium"

  def install
    ENV["VCPKG_FORCE_SYSTEM_BINARIES"] = "1"
    system "cmake", ".", "-DDISABLE_VCPKG:BOOL=ON", "-DPYTHON_EXECUTABLE=/usr/bin/python3", *std_cmake_args
    system "make", "install"
    etc.install 'etc/et.cfg' => 'et.cfg' unless File.exist? etc+'et.cfg'
  end

  service do
    run ["#{opt_bin}/etserver", "--cfgfile", "#{etc}/et.cfg"]
    keep_alive false
    working_dir "#{HOMEBREW_PREFIX}"
    error_log_path "/tmp/etmasterserver_err"
    log_path "/tmp/etmasterserver_out"
    require_root true
  end

  test do
    system "#{bin}/et", "--help"
  end
end
