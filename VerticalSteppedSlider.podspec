Pod::Spec.new do |s|
  s.name          = 'VerticalSteppedSlider'
  s.version         = '0.1.0'
  s.summary         = 'A completely configurable slider with options for steps, vertical orientation, and custom colors.'
  s.description     = <<-DESC
A completely configurable slider with options for steps, vertical orientation, and custom colors. Configurable in storyboard.
                       DESC

  s.homepage        = 'https://github.com/mludowise/VerticalSteppedSlider'
  s.screenshots     = 'https://github.com/mludowise/VerticalSteppedSlider/raw/master/readme_img/demo.gif', 'https://github.com/mludowise/VerticalSteppedSlider/raw/master/readme_img/value-limits@2x.png', 'https://github.com/mludowise/VerticalSteppedSlider/raw/master/readme_img/colors@2x.png', 'https://github.com/mludowise/VerticalSteppedSlider/raw/master/readme_img/images@2x.png'
  s.license         = { :type => 'MIT', :file => 'LICENSE' }
  s.author          = { 'Mel Ludowise' => 'mludowise@gmail.com' }
  s.source          = { :git => 'https://github.com/mludowise/VerticalSteppedSlider.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files    = 'VerticalSteppedSlider/Classes/**/*'
  s.swift_version   = '5.0'
  
  # s.resource_bundles = {
  #   'VerticalSteppedSlider' => ['VerticalSteppedSlider/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks      = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
