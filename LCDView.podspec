Pod::Spec.new do |s|
  s.name             = 'LCDView'
  s.version          = '0.0.1'
  s.summary          = 'LCD display component for UIKit'

  s.description      = <<-DESC
UIKit custom component that emulates an LCD panel.
                       DESC

  s.homepage         = 'https://github.com/coniferprod/LCDView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jere Käpyaho' => 'jere@coniferproductions.com' }
  s.source           = { :git => 'https://github.com/coniferprod/LCDView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/coniferprod'

  s.ios.deployment_target = '9.0'
  s.ios.frameworks = 'UIKit'

  #s.osx.deployment_target = '10.12.3'
  #s.osx.frameworks = 'Cocoa'

  s.source_files = 'LCDView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LCDView' => ['LCDView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
