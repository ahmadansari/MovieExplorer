# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'
inhibit_all_warnings!

#Pods List
def defaultPods
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'SwiftyBeaver'
  pod 'SwiftLint'
  pod 'Alamofire'
  pod 'Kingfisher'
  pod 'KRProgressHUD'
end

target 'MovieExplorer' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MovieExplorer
  defaultPods
  
  target 'MovieExplorerTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
