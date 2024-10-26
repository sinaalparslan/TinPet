

import UIKit
class FiltersCell1: UICollectionViewCell {

    @IBOutlet var viewMenu: UIView!
	@IBOutlet var labelMenu: UILabel!

	override func awakeFromNib() {

		super.awakeFromNib()
		viewMenu.layer.borderWidth = 1
		viewMenu.layer.borderColor = AppColor.Border.cgColor
	}

	func bindData(menu: String) {

		labelMenu.text = menu.uppercased()
	}

	func set(isSelected: Bool) {

		viewMenu.backgroundColor = isSelected ? AppColor.Theme : UIColor.systemBackground
		labelMenu.textColor = isSelected ? UIColor.white : UIColor.label
	}
}
