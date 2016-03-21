#
# Be sure to run `pod lib lint LvNormalSlider.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#


Pod::Spec.new do |s|
  s.name             = "LvNormalSlider"
  s.version          = "0.1.0"
  s.summary          = "A draggable progress control."
  s.homepage         = "https://github.com/pgbo/LvNormalSlider"
  s.license          = 'MIT'
  s.author           = { "pgbo" => "460667915@qq.com" }
  s.source           = { :git => "https://github.com/pgbo/LvNormalSlider.git", :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/pgbo'

  s.platform   = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.frameworks = 'UIKit'

end
