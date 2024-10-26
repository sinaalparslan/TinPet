
import UIKit

class HomeCollectionViewCategories: UICollectionViewCell {

	@IBOutlet var labelCategory: UILabel!

	func bindData(category: String) {

		labelCategory.text = category
	}
}
