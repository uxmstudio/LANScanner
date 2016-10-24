#
# Be sure to run `pod lib lint LANScanner.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "LANScanner"
  s.version          = "0.2.0"
  s.summary          = "Scan a Wi-Fi network for devices."
  s.description      = "Easily scan through a Wi-Fi network to find devices, their IP address and hostname."

  s.homepage         = "https://github.com/uxmstudio/LANScanner"
  s.license          = 'MIT'
  s.author           = { "Chris Anderson" => "chris@uxmstudio.com" }
  s.source           = { :git => "https://github.com/uxmstudio/LANScanner.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*', 'Pod/Module/**/*.{h,m}'

  s.module_map = 'Pod/Module/LANScanner.modulemap'

  s.public_header_files = 'Pod/Classes/**/*.h', 'Pod/Module/**/*.h'

end
