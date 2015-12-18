
Pod::Spec.new do |s|
  s.name         = "INLBreadcrumbs"
  s.version      = "1.1"
  s.summary      = "INLBreadcrumbs adds breadcrumbs to a UINavigationController"
  s.description  = "Adds breadcrumb navigation to a UINavigationController and enables pop to an arbitrary View Controller from the title view"
  s.homepage     = "https://github.com/inloop/INLBreadcrumbs"
  s.screenshots  = "https://raw.githubusercontent.com/inloop/INLBreadcrumbs/master/Demo/Screenshots/INLBreadcrumbs-iPhone.png", "https://raw.githubusercontent.com/inloop/INLBreadcrumbs/master/Demo/Screenshots/INLBreadcrumbs-iPad.png"
  s.license      = { :type => "CC0 1.0",  :file => "LICENSE" }
  s.author       = { "Tomas Hakel" => "hakel@inloop.eu" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/inloop/INLBreadcrumbs.git", :tag => s.version }
  s.source_files = "INLBreadcrumbs", "INLBreadcrumbs/**/*.{h,m}"
  s.resources    = "INLBreadcrumbs/INLNavbarTitleView.xib"
end
