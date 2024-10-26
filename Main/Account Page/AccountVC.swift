
import UIKit

class AccountVC: UIViewController {

    @IBOutlet weak var datePickerAccountBirthDay: UIDatePicker!
    @IBOutlet var imageProfile: UIImageView!
	@IBOutlet var buttonProfile: UIButton!
    @IBOutlet var textFieldFirstName: UITextField!
	@IBOutlet var textFieldLastName: UITextField!
    @IBOutlet var textFieldEmailAddress: UITextField!
	@IBOutlet var textFieldPhoneNumber: UITextField!
	@IBOutlet var textFieldMyPets: UITextField!

    @IBOutlet weak var tableViewMenu: UITableView!
    @IBOutlet weak var tableViewHeightContraint: NSLayoutConstraint!
    let userDefaults = UserDefaults.standard
    let dateFormatter = DateFormatter()
    var myAccount: Person?
    override func viewDidLoad() {

		super.viewDidLoad()

		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never

		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(actionSave(_:)))
        textFieldMyPets.isUserInteractionEnabled = false
        datePickerAccountBirthDay.datePickerMode = .date
		buttonProfile.layer.borderWidth = 1
		buttonProfile.layer.borderColor = AppColor.Border.cgColor

		let attribute = [NSAttributedString.Key.foregroundColor: UIColor.label]
		textFieldFirstName.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: attribute)
		textFieldLastName.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: attribute)
		textFieldEmailAddress.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: attribute)
		textFieldPhoneNumber.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: attribute)
        textFieldMyPets.attributedPlaceholder = NSAttributedString(string: "MyPets", attributes: attribute)
	}
	// MARK: - User actions
    func createDate() -> String {
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: datePickerAccountBirthDay.date)

    }
	@objc func actionSave(_ sender: UIButton) {
        var birthday = createDate()
        myAccount = Person(firstName: textFieldFirstName.text,
                           lastName: textFieldLastName.text, email: textFieldEmailAddress.text,
                           phoneNumber: textFieldPhoneNumber.text)
        userDefaults.setObject(myAccount, forKey: "\(textFieldFirstName.text) \(textFieldFirstName.text)")
		print(#function)
	}

	@IBAction func actionProfile(_ sender: UIButton) {

		print(#function)
	}

	@IBAction func actionDateOfBirth(_ sender: UIButton) {

		print(#function)
	}

	@IBAction func actionMyPets(_ sender: UIButton) {
        let petsVC = PetsVC()
        petsVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(petsVC, animated: true)

		print(#function)
	}
}
