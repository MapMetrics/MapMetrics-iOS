Pod::Spec.new do |spec|
  spec.name         = "MapMetrics-iOS"
  spec.version      = "0.0.3"
  spec.summary      = "MapMetrics SDK - A powerful mapping framework"
  spec.description  = <<-DESC
                      MapMetrics provides advanced offline mapping capabilities
                      with custom features for iOS applications.
                      DESC
  spec.homepage     = "https://github.com/MapMetrics/MapMetrics-iOS"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "MapMetrics" => "jack@mapmetrics.org" }
  spec.platform     = :ios, "12.0"
  spec.swift_version = "5.0"
  
  spec.source       = {
    :git => "https://github.com/MapMetrics/MapMetrics-iOS.git",
    :tag => spec.version.to_s
  }

  spec.vendored_frameworks = "MapMetrics.xcframework"
  spec.preserve_paths      = "MapMetrics.xcframework"
  
  spec.exclude_files = [
    "**/.DS_Store",
    "**/bazel-out",
    "**/*.lproj"
  ]

  spec.pod_target_xcconfig = {
    "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64",
    "OTHER_LDFLAGS" => "-framework MapMetrics",
    "LD_RUNPATH_SEARCH_PATHS" => "@executable_path/Frameworks",
    "ENABLE_USER_SCRIPT_SANDBOXING" => "NO"
  }
  
  spec.user_target_xcconfig = {
    "LD_RUNPATH_SEARCH_PATHS" => "@executable_path/Frameworks"
  }

  spec.frameworks = 'CoreLocation', 'OpenGLES', 'QuartzCore'
end
