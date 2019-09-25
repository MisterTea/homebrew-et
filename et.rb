class Et < Formula
  desc "Remote terminal with IP roaming"
  homepage "https://mistertea.github.io/EternalTerminal/"
  url "https://github.com/MisterTea/EternalTerminal/archive/et-v6.0.3.tar.gz"
  head "https://github.com/MisterTea/EternalTerminal.git"
  version "6.0.3"
  sha256 "66ea3a7518b0ec02b0ccc2484d4af7cbe5fd34a5d0ab868868a90ab99b5abec9"
  revision 1

  depends_on "cmake" => :build

  depends_on "protobuf"
  depends_on "libsodium"
  depends_on "gflags"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "-j4", "install"
    etc.install 'etc/et.cfg' => 'et.cfg' unless File.exists? etc+'et.cfg'
  end

  plist_options :startup => true

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/etserver</string>
        <string>--cfgfile</string>
        <string>#{etc}/et.cfg</string>
        <string>--daemon</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <false/>
      <key>WorkingDirectory</key>
      <string>#{HOMEBREW_PREFIX}</string>
      <key>StandardErrorPath</key>
      <string>/tmp/etmasterserver_err</string>
      <key>StandardOutPath</key>
      <string>/tmp/etmasterserver_out</string>
      <key>HardResourceLimits</key>
      <dict>
        <key>NumberOfFiles</key>
        <integer>4096</integer>
      </dict>
      <key>SoftResourceLimits</key>
      <dict>
        <key>NumberOfFiles</key>
        <integer>4096</integer>
      </dict>
    </dict>
    </plist>
    EOS
  end

  test do
    system "#{bin}/et", "--help"
  end
end
