
import UIKit

enum ElementType: String, CaseIterable {
    case age = "Age"
    case distance = "Distance"
    case name = "Name"
// Bu genellikle kullanıcı arayüzünde seçeneklerin gösterilmesi veya başka bir yerde kullanılmak üzere değerleri döndürmek için kullanılır.
    static func getAllValues() -> [String] {
        return ElementType.allCases.map { $0.rawValue }
    }

    static func getAllKeys() -> [ElementType] {
        return ElementType.allCases.map { $0 }
    }
}

enum GenderType: String, CaseIterable {
    case male = "Male"
    case female = "Female"
// Bu genellikle kullanıcı arayüzünde seçeneklerin gösterilmesi veya başka bir yerde kullanılmak üzere değerleri döndürmek için kullanılır.
    static func getAllValues() -> [String] {
        return GenderType.allCases.map { $0.rawValue }
    }

    static func getAllKeys() -> [GenderType] {
        return GenderType.allCases.map { $0 }
    }
}
enum TypePet: String, CaseIterable {
    case cat = "Cat"
    case dog = "Dog"
// Bu genellikle kullanıcı arayüzünde seçeneklerin gösterilmesi veya başka bir yerde kullanılmak üzere değerleri döndürmek için kullanılır.
    static func getAllValues() -> [String] {
        return TypePet.allCases.map { $0.rawValue }
    }

    static func getAllKeys() -> [TypePet] {
        return TypePet.allCases.map { $0 }
    }
}

class CreatePetsVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textFieldTypePet: UITextField!
    @IBOutlet weak var buttonType: UIButton!
    @IBOutlet weak var buttonKind: UIButton!
    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var buttonProfile: UIButton!
    @IBOutlet weak var textFieldGender: UITextField!
    @IBOutlet var textFieldFirstName: UITextField!
    @IBOutlet var textFieldKind: UITextField!
    @IBOutlet weak var textFieldIllness: UITextField!
    @IBOutlet weak var textFieldCoverLater: UITextField!
    @IBOutlet weak var textFieldVaccine: UITextField!
    @IBOutlet weak var collectionViewPet: UICollectionView!
    let source = ["Male", "Female"]
    let dateFormatter = DateFormatter()
    let userDefaults = UserDefaults.standard
    var listOfImage = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    var myAnimal: AnimalModel?

    var isEditingMode = true {
        didSet {
            updateUIForEditMode()
        }
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        title = "Pets Details"

        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(actionSave(_:)))
        datePicker.datePickerMode = .dateAndTime

        collectionViewPet.delegate = self
        collectionViewPet.dataSource = self
        buttonProfile.layer.borderWidth = 1
        buttonProfile.layer.borderColor = AppColor.Border.cgColor

        let attribute = [NSAttributedString.Key.foregroundColor: UIColor.label]

        registerCollectionViewCells()
        setupViews()

    }

    private func setupViews() {
        if let animal = myAnimal {
            textFieldTypePet.text = animal.type
            textFieldGender.text = animal.genre
            textFieldKind.text = animal.kind
            textFieldIllness.text = animal.illness?.first ?? ""
            textFieldVaccine.text = animal.vaccine?.first ?? ""
            textFieldFirstName.text = animal.name
            textFieldCoverLater.text = animal.coverLater
            textFieldFirstName.isUserInteractionEnabled = true

            if let date = stringToDate(value: animal.birthDate) {
                datePicker.date = date
            }

        }
    }

    private func stringToDate(value: String?) -> Date? {
        guard let value = value else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let date = dateFormatter.date(from: value)
        return date
    }

    func createDate() -> String {
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: datePicker.date)

    }

    @IBAction func actionType(_ sender: Any) {
        let gender = CustomPickerView()
        gender.setup(with: TypePet.getAllValues())

        gender.didTypeSelected = { value in
            self.textFieldTypePet.text = value
        }
        present(gender, animated: true)
        print(#function)
    }
    @IBAction func actionKind(_ sender: Any) {
        let kindOfPetVC = KindOfPetVC()
        kindOfPetVC.myType = TypePet(rawValue: textFieldTypePet.text ?? "Cat")
        kindOfPetVC.didSelectedKind = { kindOfPetVC in
            self.textFieldKind.text = kindOfPetVC
        }
        kindOfPetVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(kindOfPetVC, animated: true)

    }

    private func updateUIForEditMode() {
        print("")
        // Disable/enable user interaction based on the edit mode
        textFieldTypePet.isUserInteractionEnabled = !isEditingMode
        textFieldKind.isUserInteractionEnabled = !isEditingMode
        textFieldIllness.isUserInteractionEnabled = !isEditingMode
        textFieldVaccine.isUserInteractionEnabled = !isEditingMode
        collectionViewPet.isUserInteractionEnabled = !isEditingMode
        textFieldCoverLater.isUserInteractionEnabled = !isEditingMode
        buttonType.isUserInteractionEnabled = !isEditingMode
        buttonKind.isUserInteractionEnabled = !isEditingMode
    }
    // MARK: - User actions
    func showAlert(_ title: String, _ message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "delate", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    @objc func actionSave(_ sender: UIButton) {
        let isForEditing = myAnimal != nil
        var birthday = createDate()
        var petvaccine = textFieldVaccine.text ?? ""
        var petIllness = textFieldIllness.text ?? ""
        myAnimal = AnimalModel(
            type: textFieldTypePet.text, kind: textFieldKind.text,
            birthDate: birthday, name: textFieldFirstName.text,
            vaccine: [petvaccine],
            illness: [petIllness], photos: ["dog7.jpg"],
            coverLater: textFieldCoverLater.text, location: ["longitude": 35.8086, "latitude": 44.9334],
            genre: textFieldGender.text
        )
        var animalList = userDefaults.getObject(forKey: "animalList", castTo: [AnimalModel].self) ?? []

        if isForEditing == false {
            animalList.append(myAnimal!)
            userDefaults.setObject(animalList, forKey: "animalList")

        } else {
            var indexSelectedItem = 0
            for (index, item) in animalList.enumerated() {
                if case item.name = textFieldFirstName.text {
                    indexSelectedItem = index
                }
            }
            if let unmyanimal = myAnimal {
                animalList[indexSelectedItem] = unmyanimal
                userDefaults.setObject(animalList, forKey: "animalList")

            }
        }

        navigationController?.popViewController(animated: false)
        //        var my_animals = user.get("animalList")
        //        if my_animals is nil {
        //            tempList = [Animal]
        //            UserDefaults.setObject("anilmalList")
        //        }
        //        my_animals.append(Animal)
        //
        //        UserDefaults.setObject("anilmalList")

        print(#function)
    }

    @IBAction func actionProfile(_ sender: UIButton) {

        print(#function)
    }
    func setData(animal: AnimalModel?) {
        self.myAnimal = animal
    }
    func showImagePicker() {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)

        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        print("seçildi")
//        let newAnimalPhoto = AnimalModel().photos
//        myAnimal?.photos.append(newAnimalPhoto)

        collectionViewPet.reloadData()
    }

    @IBAction func actionGender(_ sender: UIButton) {
        let gender = CustomPickerView()
        gender.setup(with: GenderType.getAllValues())

        gender.didTypeSelected = { value in
            self.textFieldGender.text = value
        }
        present(gender, animated: true)
        print(#function)
    }
}

extension CreatePetsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfImage.count
    }
    private func registerCollectionViewCells() {
        collectionViewPet.register(UINib(nibName: "PetCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PetCollectionViewCell")
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetCollectionViewCell", for: indexPath) as? PetCollectionViewCell {
            cell.setup(url: "https://picsum.photos/id/\(indexPath.row + 50)/300/300?grayscale")
            cell.backgroundColor = .orange
            cell.cornerRadius = 17

            cell.didSelectedPetImage = { [weak self] in
                guard let self = self else { return }
                self.listOfImage.remove(at: indexPath.row)
                self.collectionViewPet.reloadData()
            }

            cell.didAddImage = { [weak self] in
                guard let self = self else { return }
                self.showImagePicker()
            }

            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        if collectionView == self.collectionViewPet {
            let width = collectionView.bounds.width
            return CGSize(width: height, height: height)
        }
        return CGSize(width: 0, height: 0)
    }
}
extension CreatePetsVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return source.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return source[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textFieldGender.text = source[row]
    }

}
