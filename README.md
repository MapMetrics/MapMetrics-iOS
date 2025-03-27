# MapMetrics-iOS

## Installation (CocoaPods)

Add this to your Podfile:

```ruby
target 'YourApp' do  
  pod 'MapMetrics-iOS', '~> 0.0.1'  # Use the latest version  
  # OR
  pod 'MapMetrics-iOS', :git => 'https://github.com/MapMetrics/MapMetrics-iOS', :tag => '0.0.1'
end
```

Run:

```bash
pod install  
```

---

## Required Build Settings (Sandbox Fix)

To prevent `rsync.samba deny(1)` errors, users must add these settings:

### Option A: Automatic Fix (via Podfile)

Add to your Podfile:

```ruby
post_install do |installer|  
  installer.pods_project.targets.each do |target|  
    target.build_configurations.each do |config|  
      # Disable sandbox restrictions  
      config.build_settings['ENABLE_USER_SCRIPT_SANDBOXING'] = 'NO'  
    end  
  end  
end  
```

Then run:

```bash
pod install  
```

### Option B: Manual Fix (Xcode Settings)

1. Open your project in Xcode.
2. Go to **Target → Build Settings**.
3. Search for `ENABLE_USER_SCRIPT_SANDBOXING`.
4. Set to **NO** for all configurations (Debug/Release).

---

## Verify Installation

Import in your code:

```swift
import MapMetrics  
```

Clean Build (if issues persist):

```bash
rm -rf ~/Library/Developer/Xcode/DerivedData/*  
```

---

## Troubleshooting

| Issue                     | Solution  |
|---------------------------|-----------|
| Sandbox deny(1) errors    | Ensure `ENABLE_USER_SCRIPT_SANDBOXING=NO` is set. |
| `pod install` fails       | Delete `Pods/` and `Podfile.lock`, then retry. |
| Version conflicts         | Run `pod update MapMetrics`. |

---

## Example Usage

Here's how to integrate **MapMetrics** into your project:

```swift
import UIKit
import MapMetrics

class ViewController: UIViewController {
    var mapView: MLNMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the map view
        let isdarkMode: Bool = true
        mapView = MLNMapView(frame: view.bounds, isDarkMode: isdarkMode)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Set the map's center coordinate and zoom level
        let center = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // San Francisco
        mapView.setCenter(center, zoomLevel: 12, animated: false)

        // Add the map view to the view controller
        view.addSubview(mapView)
    }
}
```

---

## Example Podfile (Complete)

```ruby
platform :ios, '12.0'  

target 'YourApp' do  
  use_frameworks!  
  pod 'MapMetrics-iOS', '~> 0.0.1'  

  post_install do |installer|  
    installer.pods_project.targets.each do |target|  
      target.build_configurations.each do |config|  
        config.build_settings['ENABLE_USER_SCRIPT_SANDBOXING'] = 'NO'  
      end  
    end  
  end  
end  
```

