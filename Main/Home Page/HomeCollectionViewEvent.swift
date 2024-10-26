

import UIKit

class HomeCollectionViewEvent: UICollectionViewCell {

	@IBOutlet var imageSlider: UIImageView!

	func bindData(index: Int) {

		imageSlider.sample("Ecommerce", "Candles", index)
	}
}
