# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'drp14' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for drp14
  # # add the Firebase pod for Google Analytics
  pod 'Firebase/Analytics'
  pod 'Firebase/Database'
  # or pod ‘Firebase/AnalyticsWithoutAdIdSupport’
  # for Analytics without IDFA collection capability

  # add pods for any other desired Firebase products
  # https://firebase.google.com/docs/ios/setup#available-pods
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      end
    end
  end

  target 'drp14Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'drp14UITests' do
    # Pods for testing
  end

end
