
import UIKit
class FiltersCell2: UITableViewCell {

	@IBOutlet var labelTitle: UILabel!
	@IBOutlet var imageSelected: UIImageView!

	func bindData(title: String) {

		labelTitle.text = title
	}

	func set(isSelected: Bool) {

		imageSelected.tintColor = isSelected ? AppColor.Theme : UIColor.systemGray
		imageSelected.image = UIImage(systemName: isSelected ? "checkmark.circle.fill" : "circle.fill")
	}
}
