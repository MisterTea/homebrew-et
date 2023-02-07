class Et < Formula
  desc "Remote terminal with IP roaming"
  homepage "https://mistertea.github.io/EternalTerminal/"
  url "https://github.com/MisterTea/EternalTerminal/archive/et-v6.2.4.tar.gz"
  head "https://github.com/MisterTea/EternalTerminal.git"
  version "6.2.4"
  sha256 "95cfb79bc2f25d19eb84ca3c28dba860bb52b3750334d373adeb2cd061de6ba6"
  revision 2

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "curl"
  depends_on "openssl"
  depends_on "protobuf"
  depends_on "libsodium"

  def install
    ENV["VCPKG_FORCE_SYSTEM_BINARIES"] = "1"
    system "cmake", ".", "-DDISABLE_VCPKG:BOOL=ON", "-DPYTHON_EXECUTABLE=/usr/bin/python3", *std_cmake_args
    system "make", "install"
    etc.install 'etc/et.cfg' => 'et.cfg' unless File.exists? etc+'et.cfg'
  end

  service do
    run ["#{opt_bin}/etserver", "--cfgfile", "#{etc}/et.cfg", "--daemon"]
    keep_alive false
    working_dir "#{HOMEBREW_PREFIX}"
    error_log_path "/tmp/etmasterserver_err"
    require_root true
  end

  test do
    system "#{bin}/et", "--help"
  end
end
