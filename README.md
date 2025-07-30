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
class ViewController: UIViewController, MLNMapViewDelegate {
    var mapView: MLNMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MLNMapView(
            frame: view.bounds,
            styleURL: URL(string: "<YOUR_STYLE_URL_HERE>")
        )
        mapView.delegate = self
        view.addSubview(mapView)
                mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        
        // This is a better starting position 
        let center = CLLocationCoordinate2D(latitude: 20.0, longitude: 0.0) // More centered globally
        mapView.setCenter(center, zoomLevel: 2, animated: false) // Lower zoom to see more area
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


## 📍 MapMetrics iOS Map Features Guide
This guide covers how to:

Add interactive markers with editable titles
Display dynamic earthquake clusters
Display heatmap data for earthquakes
All using MapMetrics in an iOS Swift project.


## 🔧 Prerequisites

Xcode installed (version 13 or newer recommended)
A new or existing iOS project
Add MapMetrics SDK to your project (via SPM or manual integration)

### Example via Swift Package Manager:
    : https://github.com/MapMetrics/MapMetrics-iOS
    
## 1️⃣ Setting Up the Map

In your ViewController.swift:
```swift
class ViewController: UIViewController, MLNMapViewDelegate {
    var mapView: MLNMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MLNMapView(
            frame: view.bounds,
            styleURL: URL(string: "<YOUR_STYLE_URL_HERE>")
        )
        mapView.delegate = self
        view.addSubview(mapView)
                mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        
        // This is a better starting position 
        let center = CLLocationCoordinate2D(latitude: 20.0, longitude: 0.0) // More centered globally
        mapView.setCenter(center, zoomLevel: 2, animated: false) // Lower zoom to see more area
        view.addSubview(mapView)

    }
}
```
## 2️⃣ Add Tap-to-Drop Marker with Editable Title

```swift 
override func viewDidLoad() {
    ...
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mapTapped(_:)))
    mapView.addGestureRecognizer(tapGesture)
}

@objc func mapTapped(_ sender: UITapGestureRecognizer) {
    let location = sender.location(in: mapView)
    let coordinate = mapView.convert(location, toCoordinateFrom: mapView)

    let marker = MLNPointAnnotation()
    marker.coordinate = coordinate
    marker.title = "Tap to add a name"
    mapView.addAnnotation(marker)
}
```

### Add support for selecting and editing markers:

```
func mapView(_ mapView: MLNMapView, didSelect annotation: MLNAnnotation) {
    guard let point = annotation as? MLNPointAnnotation else { return }
    selectedAnnotation = point
    showInfoView(for: point)
}
```

## 3️⃣ Displaying Clusters from GeoJSON

###Step 1: Create the source
```
let url = URL(string: "https://cdn.mapmetrics-atlas.net/Images/heatmap.geojson")!
let source = MLNShapeSource(
    identifier: "clusteredEarthquakes",
    url: url,
    options: [
        .clustered: true,
        .clusterRadius: 30
    ]
)
style.addSource(source)
```


## Step 2: Add the cluster layers

```
private func addClusterLayers(source: MLNShapeSource, to style: MLNStyle) throws {
        // Cluster layer
        let clusterLayer = MLNCircleStyleLayer(identifier: "clusters", source: source)
        clusterLayer.circleColor = NSExpression(format: "mgl_step:from:stops:(point_count, %@, %@)",
                                                UIColor.systemTeal,
                                                [100: UIColor.systemYellow, 750: UIColor.systemPink])
        clusterLayer.circleRadius = NSExpression(format: "mgl_step:from:stops:(point_count, 20, %@)",
                                                 [100: 30, 750: 40])
        clusterLayer.predicate = NSPredicate(format: "point_count >= 0")
        style.addLayer(clusterLayer)
        
        // Count layer
        let countLayer = MLNSymbolStyleLayer(identifier: "cluster-count", source: source)
        countLayer.text = NSExpression(format: "CAST(point_count_abbreviated, 'NSString')")
        countLayer.textFontNames = NSExpression(forConstantValue: ["Noto Sans Medium"])
        countLayer.textFontSize = NSExpression(forConstantValue: 12)
        countLayer.predicate = NSPredicate(format: "point_count >= 0")
        style.addLayer(countLayer)
        
        // Unclustered point layer
        let pointLayer = MLNCircleStyleLayer(identifier: "unclustered-point", source: source)
        pointLayer.circleColor = NSExpression(forConstantValue: UIColor.systemBlue)
        pointLayer.circleRadius = NSExpression(forConstantValue: 4)
        pointLayer.circleStrokeWidth = NSExpression(forConstantValue: 1)
        pointLayer.circleStrokeColor = NSExpression(forConstantValue: UIColor.white)
        pointLayer.predicate = NSPredicate(format: "point_count == nil")
        style.addLayer(pointLayer)
    }
```
### Complete Setup
```
    func setupClusters() {
        print("🟢 Starting cluster setup")
        
        guard let style = mapView.style else {
            print("🔴 CRITICAL ERROR: Map style is nil")
            return
        }
        
        guard let url = URL(string: "https://cdn.mapmetrics-atlas.net/Images/heatmap.geojson") else {
            print("🔴 ERROR: Invalid GeoJSON URL")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                print("✅ GeoJSON Size: \(data.count) bytes")
                if let geoJSON = String(data: data, encoding: .utf8) {
                    print("📦 Preview GeoJSON:\n\(geoJSON.prefix(500))")
                }
            } else {
                print("❌ Failed to fetch GeoJSON: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        task.resume()
        if let layer = style.layer(withIdentifier: "earthquakes-heat") as? MLNVectorStyleLayer {
            print("Heatmap filter: \(String(describing: layer.predicate))")
        }


        do {
            // Create source without custom cluster properties first
            let source = MLNShapeSource(
                identifier: "clusteredEarthquakes",
                url: url,
                options: [
                    .clustered: true,
                    .clusterRadius: 30
                ]
            )
            if let shapeCollection = source.shape as? MLNShapeCollectionFeature {
                var minLat = 90.0
                var maxLat = -90.0
                var minLon = 180.0
                var maxLon = -180.0

                for feature in shapeCollection.shapes {
                    if let point = feature as? MLNPointFeature {
                        let coord = point.coordinate
                        minLat = min(minLat, coord.latitude)
                        maxLat = max(maxLat, coord.latitude)
                        minLon = min(minLon, coord.longitude)
                        maxLon = max(maxLon, coord.longitude)
                    }
                    // Optionally handle more geometry types like MGLPolylineFeature or MGLPolygonFeature here
                }

                let sw = CLLocationCoordinate2D(latitude: minLat, longitude: minLon)
                let ne = CLLocationCoordinate2D(latitude: maxLat, longitude: maxLon)
                let bounds = MLNCoordinateBounds(sw: sw, ne: ne)

                let camera = mapView.cameraThatFitsCoordinateBounds(bounds, edgePadding: .init(top: 40, left: 20, bottom: 40, right: 20))
                mapView.setCamera(camera, animated: true)
            }


            
            style.addSource(source)
            print("🟢 Source added successfully")
            
            // Create and add layers...
            try addClusterLayers(source: source, to: style)
            
        } catch {
            print("🔴 ERROR: \(error.localizedDescription)")
            if let nsError = error as NSError? {
                print("User Info: \(nsError.userInfo)")
            }
        }
    }

    private func addClusterLayers(source: MLNShapeSource, to style: MLNStyle) throws {
        // Cluster layer
        let clusterLayer = MLNCircleStyleLayer(identifier: "clusters", source: source)
        clusterLayer.circleColor = NSExpression(format: "mgl_step:from:stops:(point_count, %@, %@)",
                                                UIColor.systemTeal,
                                                [100: UIColor.systemYellow, 750: UIColor.systemPink])
        clusterLayer.circleRadius = NSExpression(format: "mgl_step:from:stops:(point_count, 20, %@)",
                                                 [100: 30, 750: 40])
        clusterLayer.predicate = NSPredicate(format: "point_count >= 0")
        style.addLayer(clusterLayer)
        
        // Count layer
        let countLayer = MLNSymbolStyleLayer(identifier: "cluster-count", source: source)
        countLayer.text = NSExpression(format: "CAST(point_count_abbreviated, 'NSString')")
        countLayer.textFontNames = NSExpression(forConstantValue: ["Noto Sans Medium"])
        countLayer.textFontSize = NSExpression(forConstantValue: 12)
        countLayer.predicate = NSPredicate(format: "point_count >= 0")
        style.addLayer(countLayer)
        
        // Unclustered point layer
        let pointLayer = MLNCircleStyleLayer(identifier: "unclustered-point", source: source)
        pointLayer.circleColor = NSExpression(forConstantValue: UIColor.systemBlue)
        pointLayer.circleRadius = NSExpression(forConstantValue: 4)
        pointLayer.circleStrokeWidth = NSExpression(forConstantValue: 1)
        pointLayer.circleStrokeColor = NSExpression(forConstantValue: UIColor.white)
        pointLayer.predicate = NSPredicate(format: "point_count == nil")
        style.addLayer(pointLayer)
    }
```

## 4️⃣ Displaying Heatmap from GeoJSON

###Step 1: Add heatmap source
```
let heatmapSource = MLNShapeSource(
    identifier: "earthquakes",
    url: URL(string: "https://cdn.mapmetrics-atlas.net/Images/heatmap.geojson")!,
    options: [.clustered: false]
)
style.addSource(heatmapSource)
```

###Step 2: Add heatmap layer
```
let heatmap = MLNHeatmapStyleLayer(identifier: "earthquakes-heat", source: heatmapSource)

heatmap.heatmapWeight = ...
heatmap.heatmapColor = ...
heatmap.heatmapRadius = ...
heatmap.heatmapOpacity = NSExpression(forConstantValue: 0.8)
heatmap.isVisible = false // initially hidden

style.addLayer(heatmap)
```

### Complete Func
```
    func setupHeatmap() {
        guard let style = mapView.style else {
            print("🔴 Map style not available")
            return
        }
        
        // 1. Remove any existing source/layer to avoid duplicates
        if let existingSource = style.source(withIdentifier: "earthquakes") {
            style.removeSource(existingSource)
        }
        if let existingLayer = style.layer(withIdentifier: "earthquakes-heat") {
            style.removeLayer(existingLayer)
        }
        
        // 2. Create the source with proper options
        let url = URL(string: "https://cdn.mapmetrics-atlas.net/Images/heatmap.geojson")!
        let source: MLNShapeSource
        
        do {
            source = MLNShapeSource(
                identifier: "earthquakes",
                url: url,
                options: [.clustered: false] // Important for heatmap
            )
            
            style.addSource(source)
            print("🟢 Heatmap source added successfully")
            
            // 3. Create the heatmap layer with proper configuration
            let heatmap = MLNHeatmapStyleLayer(identifier: "earthquakes-heat", source: source)
            
            // Weight based on magnitude with exponential scaling
            heatmap.heatmapWeight = NSExpression(
                forMLNInterpolating: NSExpression(forKeyPath: "mag"),
                curveType: .exponential,
                parameters: NSExpression(forConstantValue: 1.5),
                stops: NSExpression(forConstantValue: [
                    0: 0,
                    1: 0.2,
                    3: 0.4,
                    5: 1.0
                ])
            )
            
            // Dynamic intensity based on zoom level
            heatmap.heatmapIntensity = NSExpression(
                forMLNInterpolating: .zoomLevelVariable,
                curveType: .linear,
                parameters: nil,
                stops: NSExpression(forConstantValue: [
                    0: 0.5,
                    5: 1.5,
                    10: 3.0
                ])
            )
            
            // Color gradient from cool to hot
            heatmap.heatmapColor = NSExpression(
                forMLNInterpolating: NSExpression(forVariable: "heatmapDensity"),
                curveType: .linear,
                parameters: nil,
                stops: NSExpression(forConstantValue: [
                    0: UIColor.blue.withAlphaComponent(0),
                    0.2: UIColor.blue,
                    0.4: UIColor.cyan,
                    0.6: UIColor.green,
                    0.8: UIColor.yellow,
                    1.0: UIColor.red
                ])
            )
            
            // Radius that changes with zoom
            heatmap.heatmapRadius = NSExpression(
                forMLNInterpolating: .zoomLevelVariable,
                curveType: .linear,
                parameters: nil,
                stops: NSExpression(forConstantValue: [
                    0: 5,
                    5: 10,
                    10: 20
                ])
            )
            
            heatmap.heatmapOpacity = NSExpression(forConstantValue: 0.8)
            heatmap.isVisible = false // Start hidden
            
            // 4. Add the layer in the correct position (above base but below labels)
            if let waterLayer = style.layer(withIdentifier: "water") {
                style.insertLayer(heatmap, above: waterLayer)
            } else {
                style.addLayer(heatmap)
            }
            
            print("🟢 Heatmap layer added successfully")
            
        }
    }
```

##🧪 Debugging Tips
```
func debugLayers() {
    for layer in mapView.style?.layers ?? [] {
        print("🔍 \(layer.identifier): visible=\\(layer.isVisible)")
    }
}
```
