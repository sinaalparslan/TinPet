

import UIKit

class Home2Cell3: UICollectionViewCell {

	@IBOutlet var imageProduct: UIImageView!
	@IBOutlet var buttonMore: UIButton!
	@IBOutlet var labelTitle: UILabel!
	@IBOutlet var labelBrandName: UILabel!
	@IBOutlet var labelPrice: UILabel!
	@IBOutlet var labelOriginalPrice: UILabel!

	override func awakeFromNib() {

		super.awakeFromNib()
		buttonMore.layer.borderWidth = 1
		buttonMore.layer.borderColor = AppColor.Border.cgColor
	}

	func bindData(index: Int, data: [String: String]) {

		guard let title = data["title"] else { return }
		guard let brand = data["brand"] else { return }
		guard let price = data["price"] else { return }
		guard let originalPrice = data["originalPrice"] else { return }

		imageProduct.sample("Ecommerce", "Furniture", index)
		labelTitle.text = title
		labelBrandName.text = brand
		labelPrice.text = price
		labelOriginalPrice.text = originalPrice
	}
}
