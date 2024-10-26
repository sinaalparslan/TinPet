

import UIKit
import MapKit

class PetsMapVC: UIViewController, MKMapViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var mapView: MKMapView!
    let locationManager = CLLocationManager()

    var animalList: [AnimalModel]?
    var currentLocation: CLLocation?
    // viewDidLoad genellikle görünümle ilgili başlangıç yapılandırmaları ve ayarlamaları yapmak için kullanılır.
    override func viewDidLoad() {

        super.viewDidLoad()

        mapView.delegate = self

        collectionView.dataSource = self
        collectionView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(actionMenu(_:)))

        collectionView.register(UINib(nibName: "PetMapCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "PetMapCollectionViewCell")

        let cellWidth = UIScreen.main.bounds.width - 40
        let sectionSpacing = CGFloat(20)
        let cellSpacing = CGFloat(10)

        if let layout = collectionView.collectionViewLayout as? PetsMapPagingCollectionViewLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
            layout.itemSize = CGSize(width: cellWidth, height: collectionView.frame.size.height)
            layout.minimumLineSpacing = cellSpacing
            collectionView.collectionViewLayout = layout
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.decelerationRate = .fast
        }

        loadData()
        reloadLocations()
    }
    func reloadLocations() {
        //        async bir işlem gerçekleştiriyoruz getlocation çalışırken. location ve
        //        error bilgisini çekiiyoruz hangisine düştüyse ona göre işlem yapıyoruz
        //        location a düşerse current locationda verimizi tutuyoruz muhtemelen daha
        //        sonrasında  sayfamızda kullanacağımızdan reload ediyoruz
        //        //Bu kod parçası, bir konum yöneticisi olan LocationManager'ın getLocation
        //        metodunu kullanarak cihazın mevcut konumunu almayı amaçlar. Bu işlem asenkron
        //        bir yapıda gerçekleşir, yani konum verisi alındığında bir kapanış (closure)
        //        içinde belirtilen işlemler gerçekleştirilir.
        LocationManager.shared.getLocation { [weak self] location, error in
            if let error = error { return }
            guard let location = location else { return }
            self?.currentLocation = location
            self?.collectionView.reloadData()
            self?.drawRoute(detinationPoint: (self?.animalList![0].get2DLocation())!)
        }
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        if let navController = navigationController as? NavigationController {
            navController.setBackground(color: .clear)
        }

        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    // bir görünüm kontrolcüsü görünümden kaybolduğunda çağrılır.
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)

        if let navBar = navigationController as? NavigationController {
            navBar.setNavigationBar()
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5.0
        return renderer
    }

    // MARK: - Data methods
    func loadData() {
        refreshCollectionView()
    }

    // MARK: - Refresh methods
    func refreshCollectionView() {

        collectionView.reloadData()
    }

    // MARK: - User actions
    @objc func actionMenu(_ sender: UIButton) {

        print(#function)
    }

    @objc func actionFavorite(_ sender: UIButton) {

        print(#function)
    }

}

extension PetsMapVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Calculate the index of the currently visible cell
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let indexPath = collectionView.indexPathForItem(at: visiblePoint) {
            if let animal = animalList?[indexPath.item] {
                if let destination = animal.get2DLocation() {
                    drawRoute(detinationPoint: destination)
                }
            }
        }
    }

    func drawRoute(detinationPoint: CLLocationCoordinate2D) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        if let currentLocation = currentLocation {
            showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D(latitude:
                                                                        currentLocation.coordinate.latitude, longitude:
                                                                        currentLocation.coordinate.longitude), destinationCoordinate: detinationPoint)
        }

    }
}

// MARK: - UICollectionViewDataSource

extension PetsMapVC: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return animalList?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetMapCollectionViewCell",
                                                         for: indexPath) as? PetMapCollectionViewCell { if let animal = animalList?[indexPath.row] {
                                                             if let currentLocation = currentLocation,
                                                                let lat = animal.getLocation().latitude, let long = animal.getLocation().longitude {
                                                                 let tempLocation = CLLocation(latitude: lat, longitude: long)
                                                                 let distance = tempLocation.distance(from: currentLocation)
                                                                 cell.bindData(index: indexPath.item, data: animal, distance: distance)
                                                             } else {
                                                                 cell.bindData(index: indexPath.item, data: animal, distance: nil)
                                                             }
                                                             return cell
                                                         }
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate

extension PetsMapVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print(#function)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PetsMapVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (collectionView.frame.size.width)
        return CGSize(width: width, height: collectionView.frame.size.height)
    }
}

// MARK: - CLLocationManagerDelegate

extension PetsMapVC: CLLocationManagerDelegate {
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile

        let directions = MKDirections(request: request)

        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }

            // for getting just one route
            if let route = unwrappedResponse.routes.first {
                // show on map
                self.mapView.addOverlay(route.polyline)
                // set the map area to show the route
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding:
                                                UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 300, right: 20.0), animated: true)

                let annotation = MKPointAnnotation()
                annotation.title = "Your text here"
                // You can also add a subtitle that displays under the annotation such as
                annotation.subtitle = "One day I'll go here..."
                annotation.coordinate = destinationCoordinate
                self.mapView.addAnnotation(annotation)
            } else {
                showAlert("Error", "\(String(describing: error))")
            }

            // if you want to show multiple routes then you can get all routes in a loop in the following statement
            // for route in unwrappedResponse.routes {}
        }
    }
    func showAlert(_ title: String, _ message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Error", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

        mapView.setRegion(region, animated: true)
    }
}
