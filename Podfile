platform :ios, '14.0'

target 'SDK-Sample' do
 use_frameworks!

  pod 'SaootiSDK', :git => 'https://<github_login>:<github_token>M@github.com/saooti/ios-sdk.git'

end

post_install do |installer|
 installer.pods_project.targets.each do |target|
   target.build_configurations.each do |config|
     config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
   end
 end
end
