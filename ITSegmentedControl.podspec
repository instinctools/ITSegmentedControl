#
# Be sure to run `pod lib lint ITSegmentedControl.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ITSegmentedControl"
  s.version          = "0.0.2"
  s.summary          = "Customizible segmented control with tilting edges"
  s.homepage         = "https://github.com/alesarno/ITSegmentedControl"
  s.license          = 'MIT'
  s.author           = { "Alex Rudyak" => "al.rudyak@gmail.com" }
  s.source           = { :git => "https://github.com/alesanro/ITSegmentedControl.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.frameworks = 'UIKit', 'QuartzCore', 'Foundation'
end
