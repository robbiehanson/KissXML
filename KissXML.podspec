Pod::Spec.new do |s|
  s.name         = 'KissXML'
  s.version      = '5.3.1'
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.summary      = 'A replacement for Cocoa\'s NSXML cluster of classes. Based on libxml.'
  s.homepage     = 'https://github.com/robbiehanson/KissXML'
  s.author       = { 'Robbie Hanson' => 'robbiehanson@deusty.com' }
  s.source       = { :git => 'https://github.com/robbiehanson/KissXML.git', :tag => s.version }

  s.requires_arc = true

  s.default_subspec = 'All'

  s.subspec 'Core' do |ss|
    ss.source_files = 'KissXML/*.{h,m}', 'KissXML/Categories/*.{h,m}', 'KissXML/Private/*.h'
    ss.private_header_files = 'KissXML/Private/**/*.h'
    ss.library      = 'xml2'
    ss.xcconfig     = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2'}
  end

  s.subspec 'Additions' do |ss|
    ss.dependency 'KissXML/Core'
    ss.source_files = 'KissXML/Additions/*.{h,m}'
  end

  s.subspec 'All' do |ss|
    ss.dependency 'KissXML/Core'
    ss.dependency 'KissXML/Additions'
  end

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'
end
