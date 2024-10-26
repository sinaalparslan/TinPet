

import UIKit

class SignUpVC: UIViewController {

	@IBOutlet var textFieldFirstName: UITextField!
	@IBOutlet var textFieldLastName: UITextField!
	@IBOutlet var textFieldEmail: UITextField!
	@IBOutlet var textFieldPassword: UITextField!
	@IBOutlet var textFieldPassword2: UITextField!
    @IBOutlet var textFieldTelefoneNumber: UITextField!
    override func viewDidLoad() {

		super.viewDidLoad()

		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never

		navigationItem.titleView = UIImageView(image: UIImage(systemName: "circles.hexagongrid.fill"))

		textFieldFirstName.setLeftPadding(value: 15)
		textFieldLastName.setLeftPadding(value: 15)
		textFieldEmail.setLeftPadding(value: 15)
		textFieldPassword.setLeftPadding(value: 15)
		textFieldPassword2.setLeftPadding(value: 15)
        textFieldTelefoneNumber.setLeftPadding(value: 15)

	}
	@IBAction func actionContinue(_ sender: Any) {

        let viewController = LoginVC()
        viewController.isModalInPresentation = true
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
	}
	@IBAction func actionTerms(_ sender: Any) {

		print(#function)
		dismiss(animated: true)
	}

	@IBAction func actionPrivacy(_ sender: Any) {

		print(#function)
		dismiss(animated: true)
	}
}
