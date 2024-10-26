

import UIKit
class LoginVC: UIViewController {

	@IBOutlet var labelTitle: UILabel!
	@IBOutlet var labelSubTitle: UILabel!
	@IBOutlet var imageViewLogo: UIImageView!
	@IBOutlet var textFieldEmail: UITextField!
	@IBOutlet var textFieldPassword: UITextField!
	@IBOutlet var buttonHideShowPassword: UIButton!
	override func viewDidLoad() {

		super.viewDidLoad()

		textFieldEmail.setLeftPadding(value: 15)
		textFieldPassword.setLeftPadding(value: 15)
		textFieldPassword.setRightPadding(value: 40)

		loadData()
	}

	// MARK: - Data methods
	func loadData() {

		labelTitle.text = "Welcome to\nTinPets"
		labelSubTitle.text = "Create perfect memories with your furry friends!"
	}

	// MARK: - User actions
	@IBAction func actionHideShowPassword(_ sender: Any) {

		buttonHideShowPassword.isSelected = !buttonHideShowPassword.isSelected
		textFieldPassword.isSecureTextEntry = !buttonHideShowPassword.isSelected
	}

	@IBAction func actionLogin(_ sender: Any) {
        guard let enteredEmail = textFieldEmail.text, let enteredPassword = textFieldPassword.text else {
                return
            }

            let sinaEmail = "sina@gmail.com"
            let sinaPassword = "1234"

//            if enteredEmail == sinaEmail && enteredPassword == sinaPassword {
            if true {

                let viewController = RootViewController()
                viewController.isModalInPresentation = true
                viewController.modalPresentationStyle = .fullScreen
                navigationController?.pushViewController(viewController, animated: true)
            } else {

                showAlert(" Hatalı Giriş", "E-posta veya şifreniz yanlış. Lütfen tekrar deneyin.")
            }
	}
    func showAlert(_ title: String, _ message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
	@IBAction func actionForgotPassword(_ sender: Any) {

		print(#function)
		dismiss(animated: true)
	}

	@IBAction func actionSignUp(_ sender: Any) {
		print(#function)
        let signUpVC = SignUpVC()

        navigationController?.pushViewController(signUpVC, animated: true)

	}
}
