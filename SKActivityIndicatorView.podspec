#
# Be sure to run `pod lib lint SKActivityIndicatorView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SKActivityIndicatorView'
  s.version          = '0.1.0'
  s.summary          = 'A lightweight and easy-to-use ActivityIndicator for your iOS app written in swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    SKActivityIndicatorView is a lightweight and simple ActivityIndicator. Its really easy to integrate and easy-to-use and also has four different ActivityIndicator style with other customization options.
                       DESC

  s.homepage         = 'https://github.com/SachK13/SKActivityIndicatorView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SachK13' => 'iosdev.sachin@gmail.com' }
  s.source           = { :git => 'https://github.com/SachK13/SKActivityIndicatorView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SKActivityIndicatorView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SKActivityIndicatorView' => ['SKActivityIndicatorView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
