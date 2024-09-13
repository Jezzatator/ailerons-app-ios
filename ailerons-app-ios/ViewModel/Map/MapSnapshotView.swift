//
//  MapSnapShot.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 10/09/2024.
//

import SwiftUI
import MapKit

struct MapSnapshotView: UIViewRepresentable {
    let polylines: [MKPolyline]

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        let region = calculateRegion(for: polylines)
        takeSnapshot(region: region, polylines: polylines) { snapshotImage in
            imageView.image = snapshotImage
        }
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        let region = calculateRegion(for: polylines)
        takeSnapshot(region: region, polylines: polylines) { snapshotImage in
            uiView.image = snapshotImage
        }
    }

    private func takeSnapshot(region: MKCoordinateRegion, polylines: [MKPolyline], completion: @escaping (UIImage?) -> Void) {
        let options = MKMapSnapshotter.Options()
        options.region = region
        options.size = CGSize(width: 428, height: 220)
        options.scale = UIScreen.main.scale

        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                print("Erreur lors de la capture du snapshot: \(String(describing: error))")
                completion(nil)
                return
            }

            let image = snapshot.image
            UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale)
            image.draw(at: CGPoint.zero)

            let context = UIGraphicsGetCurrentContext()

            // Dessiner les polylignes sur l'instantané
            context?.setLineWidth(2.0)
            context?.setStrokeColor(UIColor.red.cgColor)

            for polyline in polylines {
                let points = polyline.points()
                let pointCount = polyline.pointCount

                var coordinates = [CGPoint]()
                for i in 0..<pointCount {
                    let point = snapshot.point(for: points[i].coordinate)
                    coordinates.append(point)
                }

                context?.beginPath()
                for i in 0..<coordinates.count {
                    let point = coordinates[i]
                    if i == 0 {
                        context?.move(to: point)
                    } else {
                        context?.addLine(to: point)
                    }
                }
                context?.strokePath()
            }

            let finalImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            completion(finalImage)
        }
    }

    // Calcul de la région pour inclure tous les tracés
    private func calculateRegion(for polylines: [MKPolyline]) -> MKCoordinateRegion {
        var minLat = Double.greatestFiniteMagnitude
        var maxLat = -Double.greatestFiniteMagnitude
        var minLon = Double.greatestFiniteMagnitude
        var maxLon = -Double.greatestFiniteMagnitude

        for polyline in polylines {
            for i in 0..<polyline.pointCount {
                let coordinate = polyline.points()[i].coordinate
                minLat = min(minLat, coordinate.latitude)
                maxLat = max(maxLat, coordinate.latitude)
                minLon = min(minLon, coordinate.longitude)
                maxLon = max(maxLon, coordinate.longitude)
            }
        }

        let centerLat = (minLat + maxLat) / 2
        let centerLon = (minLon + maxLon) / 2
        let spanLat = (maxLat - minLat) * 1.2 // Ajout d'un léger zoom pour ne pas couper les bords
        let spanLon = (maxLon - minLon) * 1.2

        let center = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon)
        let span = MKCoordinateSpan(latitudeDelta: spanLat, longitudeDelta: spanLon)
        
        return MKCoordinateRegion(center: center, span: span)
    }
}
