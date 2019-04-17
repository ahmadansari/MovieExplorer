# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

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
