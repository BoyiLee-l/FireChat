# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'FireChat' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FireChat
  pod 'SnapKit'
  pod 'Firebase/Core'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'Firebase/Database' 
  pod 'Firebase/Storage'
  pod 'SDWebImage', '~> 5.0'
  pod 'JGProgressHUD'
end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end