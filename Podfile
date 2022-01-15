# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target '오늘의 나' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire'
  pod 'SideMenu'
  pod 'naveridlogin-sdk-ios'
  pod 'KakaoSDK'
  pod 'Floaty', '~> 4.2.0'
  pod 'SwiftKeychainWrapper'
  pod 'Firebase/Messaging'
  pod 'RxSwift', '6.0.0'
  pod 'RxCocoa', '6.0.0'

  # Pods for 오늘의 나

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
            config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
        end
    end
end

end
