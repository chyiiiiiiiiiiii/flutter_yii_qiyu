#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint qiyu.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'qiyu'
  s.version          = '0.0.1'
  s.summary          = 'Qiyu Flutter Package'
  s.description      = <<-DESC
Qiyu Flutter Package
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Yii' => 'ab20803@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'QY_iOS_SDK', '~>5.15.0'
  s.dependency 'ObjectMapper', '~>3.5'
  s.dependency 'SwiftyJSON', '~>4.0'
  s.platform = :ios, '10.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.3.2'
end
