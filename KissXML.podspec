Pod::Spec.new do |s|
  s.name         = 'KissXML'
  s.version      = '5.0.2'
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.summary      = 'A replacement for Cocoa\'s NSXML cluster of classes. Based on libxml.'
  s.homepage     = 'https://github.com/robbiehanson/KissXML'
  s.author       = { 'Robbie Hanson' => 'robbiehanson@deusty.com' }
  s.source       = { :git => 'https://github.com/robbiehanson/KissXML.git', :tag => s.version }

  s.requires_arc = true
  s.default_subspecs = 'Standard'

  s.subspec 'Core' do |ss|
    ss.source_files = 'KissXML/**/*.{h,m}'
    ss.library      = 'xml2'
    ss.xcconfig     = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2'}
  end

  s.subspec 'Standard' do |ss|
    ss.dependency 'KissXML/Core'
    ss.xcconfig     = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2',
                        'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
                        'OTHER_CFLAGS' => "$(inherited) -DDDXML_NS_DECLARATIONS_ENABLED=1 -DDDXML_LIBXML_MODULE_ENABLED=0"}
  end

  s.subspec 'libxml_module' do |ss|
    ss.dependency 'KissXML/Core'
    ss.ios.source_files  = 'KissXML/**/*.swift'
    ss.preserve_path = 'libxml/module.modulemap'
    ss.xcconfig     = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2 $(PODS_ROOT)/KissXML/libxml "$(PODS_ROOT)/../../../libxml"',
                        'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'NO',
                        'OTHER_CFLAGS' => "$(inherited) -DDDXML_NS_DECLARATIONS_ENABLED=1 -DDDXML_LIBXML_MODULE_ENABLED=1",
                        'OTHER_SWIFT_FLAGS' => "$(inherited) -DDDXML_NS_DECLARATIONS_ENABLED -DDDXML_LIBXML_MODULE_ENABLED"
                      }
  end

  s.ios.deployment_target = "6.0"
  s.osx.deployment_target = "10.8"
  s.tvos.deployment_target = '9.0'
end
