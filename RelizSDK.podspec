
Pod::Spec.new do |spec|

  spec.name         = "RelizSDK"
  spec.version      = "1.0.1"
  spec.summary      = "RelizSDK"
  spec.description  = "Small example to test code sharing via cocoapods."	
  
  spec.homepage     = "https://github.com/nersonSwift/RelizKit"

  spec.license      = "MIT"

  spec.author       = { 
	"Angel-senpai" => "daniil.murygin68@gmail.com", 
	"nersonSwift" => "aleksandrsenin@icloud.com" 
  }
 
  spec.source       = { 
	:git => "https://github.com/nersonSwift/RelizKit.git", 
	:tag => spec.name.to_s + "_v" + spec.version.to_s
  }

  spec.swift_version = '5.3'
  spec.ios.deployment_target  = '13.0'

  spec.requires_arc = true

  spec.default_subspec = 'Core'
  
  spec.subspec 'CoreOnly' do |ss|
    ss.source_files = 'RelizSDK/RelizSDK.h'
    ss.preserve_paths = 'RelizSDK/module.modulemap'
    ss.dependency "RelizKit"
    ss.user_target_xcconfig = {
        'HEADER_SEARCH_PATHS' => "$(inherited) ${PODS_ROOT}/RelizSDK/RelizSDK/"
    }
  end

  spec.subspec 'Core' do |ss|
    ss.dependency 'RelizSDK/CoreOnly'
    ss.dependency 'RelizSDK/RZUIKit'
    ss.dependency 'RelizSDK/RZStoreKit'
    ss.dependency 'RelizSDK/RZEvent'
  end

  spec.subspec 'RZUIKit' do |ss|
    ss.dependency 'RelizSDK/CoreOnly'
    ss.dependency 'RZUIKit'
  end

  spec.subspec 'RZViewBuilder' do |ss|
    ss.dependency 'RelizSDK/CoreOnly'
    ss.dependency "RZViewBuilder"
  end

  spec.subspec 'RZScreensKit' do |ss|
    ss.dependency 'RelizSDK/CoreOnly'
    ss.dependency "RZScreensKit"
  end

  spec.subspec 'RZDarkModeKit' do |ss|
    ss.dependency 'RelizSDK/CoreOnly'
    ss.dependency "RZDarkModeKit"
  end

  spec.subspec 'RZStoreKit' do |ss|
    ss.dependency 'RelizSDK/CoreOnly'
    ss.dependency "RZStoreKit"
  end

  spec.subspec 'RZEvent' do |ss|
    ss.dependency 'RelizSDK/CoreOnly'
    ss.dependency "RZEvent"
  end

end