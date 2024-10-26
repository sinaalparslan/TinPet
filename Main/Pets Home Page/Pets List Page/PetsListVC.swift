

import UIKit
import CoreLocation
class PetsListVC: UIViewController {

	@IBOutlet var collectionView: UICollectionView!
	@IBOutlet var viewSortBy: UIView!
	@IBOutlet var viewFilters: UIView!

    var animalList: [AnimalModel]?

    var currentLocation: CLLocation?

	override func viewDidLoad() {

		super.viewDidLoad()
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never

		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(actionMenu(_:)))

		viewSortBy.layer.borderWidth = 1
		viewSortBy.layer.borderColor = AppColor.Border.cgColor

		viewFilters.layer.borderWidth = 1
		viewFilters.layer.borderColor = AppColor.Border.cgColor

		collectionView.register(UINib(nibName: "PetListCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "PetListCollectionViewCell")

		loadData()

        reloadLocations()
	}

    func reloadLocations() {
        LocationManager.shared.getLocation { [weak self] location, error in
            if let error = error { return }
            guard let location = location else { return }
            self?.currentLocation = location
            self?.collectionView.reloadData()
        }
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

	@IBAction func actionSortBy(_ sender: UIButton) {
        let sortByVC = CustomPickerView()

        sortByVC.setup(with: ElementType.getAllValues(), labelName: "Sort by")

        sortByVC.didTypeSelected = { value in

            guard let value = value else { return }
            let sortType = ElementType(rawValue: value)
            switch sortType {
            case .age:
                // in-place
                self.animalList = self.animalList?.sorted(by: { first, second in
                    (first.birthDate?.toDate())! > (second.birthDate?.toDate())!
                })
                self.refreshCollectionView()
            case .distance:
                // in-place
                self.animalList = self.animalList?.sorted(by: { first, second in
                    (first.birthDate?.toDate())! > (second.birthDate?.toDate())!
                })
                self.refreshCollectionView()
            case .name:
                // in-place
                self.animalList = self.animalList?.sorted(by: { first, second in
                    first.name! < second.name!
                })
                self.refreshCollectionView()
            case .none:
                break
            }

        }
        present(sortByVC, animated: true)
		print(#function)
	}

	@IBAction func actionFilter(_ sender: UIButton) {

		print(#function)
	}

	@objc func actionFavorite(_ sender: UIButton) {

		print(#function)
	}
}

// MARK: - UICollectionViewDataSource

extension PetsListVC: UICollectionViewDataSource {

	func numberOfSections(in collectionView: UICollectionView) -> Int {

		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return animalList?.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetListCollectionViewCell", for: indexPath) as? PetListCollectionViewCell {

            if let animal = animalList?[indexPath.row] {
                if let currentLocation = currentLocation, let lat = animal.getLocation().latitude, let long = animal.getLocation().longitude {
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

extension PetsListVC: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		print(#function)
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PetsListVC: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		let width = (collectionView.frame.size.width-45)/2
		return CGSize(width: width, height: 215)
	}

func collectionView(_ collectionView: UICollectionView,
                    layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

		return 15
	}

func collectionView(_ collectionView: UICollectionView,
                    layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

		return 15
	}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

		return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
	}
}

// MARK: - UIColor

extension UIColor {

	func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {

		return UIGraphicsImageRenderer(size: size).image { rendererContext in
			setFill()
			rendererContext.fill(CGRect(origin: .zero, size: size))
		}
	}
}

extension String {

    func toDate() -> Date? {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthDate = dateFormatter.date(from: self)
        return birthDate
    }
}
