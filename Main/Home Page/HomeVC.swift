

import UIKit

class HomeVC: UIViewController {

	@IBOutlet var viewTitle: UIView!
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var labelTitle: UILabel!
	@IBOutlet var viewProfile: UIView!
	@IBOutlet var imageViewProfile: UIImageView!
	@IBOutlet var collectionViewSlider: UICollectionView!
	@IBOutlet var collectionViewCategories: UICollectionView!
	@IBOutlet var layoutConstraintCategoriesHeight: NSLayoutConstraint!
	@IBOutlet var collectionViewDiscounts: UICollectionView!
	@IBOutlet var layoutConstraintDiscountsHeight: NSLayoutConstraint!

    @IBOutlet weak var viewDiscountHeader: UIView!
    @IBOutlet weak var viewDiscountBody: UIView!

    private var sliderVisibleIndex = IndexPath(item: 0, section: 0)
	private var categories: [String] = []
	private var products: [[String: String]] = []

	override func viewDidLoad() {

		super.viewDidLoad()

		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: viewProfile)

        setupCollectionViews()

        viewDiscountBody.isHidden = true
        viewDiscountHeader.isHidden = true

		loadData()
	}

    func setupCollectionViews() {

        collectionViewSlider.register(UINib(nibName: "HomeCollectionViewEvent", bundle: Bundle.main), forCellWithReuseIdentifier: "HomeCollectionViewEvent")
        collectionViewCategories.register(UINib(nibName: "HomeCollectionViewCategories",
                                                bundle: Bundle.main), forCellWithReuseIdentifier: "HomeCollectionViewCategories")
        collectionViewDiscounts.register(UINib(nibName: "Home2Cell3",
                                               bundle: Bundle.main), forCellWithReuseIdentifier: "Home2Cell3")

        collectionViewSlider.dataSource = self
        collectionViewSlider.delegate = self

        collectionViewCategories.dataSource = self
        collectionViewCategories.delegate = self

        collectionViewDiscounts.dataSource = self
        collectionViewDiscounts.delegate = self

        let cellWidth = UIScreen.main.bounds.width - 100
        let sectionSpacing = CGFloat(50)
        let cellSpacing = CGFloat(15)

        if let layout = collectionViewSlider.collectionViewLayout as? Home2PagingCollectionViewLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
            layout.itemSize = CGSize(width: cellWidth, height: collectionViewSlider.frame.size.height)
            layout.minimumLineSpacing = cellSpacing
            collectionViewSlider.collectionViewLayout = layout
            collectionViewSlider.translatesAutoresizingMaskIntoConstraints = false
            collectionViewSlider.decelerationRate = .fast
        }
    }

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()

		layoutConstraintCategoriesHeight.constant = collectionViewCategories.contentSize.height
		layoutConstraintDiscountsHeight.constant = collectionViewDiscounts.contentSize.height
	}

	// MARK: - Data methods
	func loadData() {

		labelTitle.text = "TinPets"
        categories.removeAll()
                products.removeAll()
                categories.append("Shoes")
                categories.append("Shirts")
                categories.append("Watches")
                categories.append("Jeans")
                var dict1: [String: String] = [:]
                dict1["title"] = "Suede Chukka Boots"
                dict1["brand"] = "River Island"
                dict1["price"] = "$79.00"
                dict1["originalPrice"] = ""
                products.append(dict1)
                var dict2: [String: String] = [:]
                dict2["title"] = "Platform Derby Shoes"
                dict2["brand"] = "Stella McCartney"
                dict2["price"] = "$384"
                dict2["originalPrice"] = "$640"
                products.append(dict2)
                var dict3: [String: String] = [:]
                dict3["title"] = "Hiking boots"
                dict3["brand"] = "Dolce & Gabbana"
                dict3["price"] = "$59"
                dict3["originalPrice"] = "$70"
                products.append(dict3)
                var dict4: [String: String] = [:]
                dict4["title"] = "Motocross boots"
                dict4["brand"] = "Hermes"
                dict4["price"] = "$48"
                dict4["originalPrice"] = ""
                products.append(dict4)
                var dict5: [String: String] = [:]
                dict5["title"] = "Riding boots"
                dict5["brand"] = "Armani"
                dict5["price"] = "$98"
                dict5["originalPrice"] = ""
                products.append(dict5)
                var dict6: [String: String] = [:]
                dict6["title"] = "Jodhpur Boots"
                dict6["brand"] = "House of Versace"
                dict6["price"] = "$75"
                dict6["originalPrice"] = "$97"
                products.append(dict6)

		refreshCollectionViewSlider()
		refreshCollectionViewCategories()
		refreshCollectionViewDiscounts()
	}

	// MARK: - Refresh methods
	func refreshCollectionViewSlider() {

		collectionViewSlider.reloadData()
	}

	func refreshCollectionViewCategories() {

		collectionViewCategories.reloadData()
	}

	func refreshCollectionViewDiscounts() {

		collectionViewDiscounts.reloadData()
	}

	// MARK: - User actions
	@IBAction func actionProfile(_ sender: UIButton) {

		print(#function)

        let accountVC = CreatePetsVC()
        accountVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(accountVC, animated: true)
//		dismiss(animated: true)
	}

	@objc func actionDiscountsMore(_ sender: UIButton) {

		print(#function)
		dismiss(animated: true)
	}

	@IBAction func actionSeeAllCategories(_ sender: UIButton) {
//        let createPetVC = CreatePetsVC()
//        let createPetVC = PetsHomeVC()
//        createPetVC.modalPresentationStyle = .fullScreen
//        navigationController?.pushViewController(createPetVC, animated: true)
		print(#function)
	}

	@IBAction func actionSeeAllDiscounts(_ sender: UIButton) {
        let createPetsVC = CreatePetsVC()
        createPetsVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(createPetsVC, animated: true)

	}
}

// MARK: - UICollectionViewDataSource
extension HomeVC: UICollectionViewDataSource {

	func numberOfSections(in collectionView: UICollectionView) -> Int {

		return 1
	}
// Bu metod, belirli bir koleksiyon görünümündeki bölümde bulunan öğe sayısını belirtir.
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		if collectionView == collectionViewSlider { return 10 }
		if collectionView == collectionViewCategories { return 4 }
		if collectionView == collectionViewDiscounts { return 6 }

		return 0
	}
// Bu metod, belirli bir koleksiyon görünümündeki belirli bir hücreyi döndürür.bu hücreleri özelleştirmek için bindData metodunu çağırıyoruz.
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		if collectionView == collectionViewSlider {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewEvent", for: indexPath) as? HomeCollectionViewEvent {
                cell.bindData(index: indexPath.item)
                return cell
            }
            return UICollectionViewCell()
		}

		if collectionView == collectionViewCategories {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCategories",
                                                             for: indexPath) as? HomeCollectionViewCategories {
                cell.bindData(category: categories[indexPath.row])
                return cell
            }
            return UICollectionViewCell()
		}

		if collectionView == collectionViewDiscounts {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Home2Cell3", for: indexPath) as? Home2Cell3 {
                cell.bindData(index: indexPath.item, data: products[indexPath.row])
                cell.buttonMore.tag = indexPath.row
                cell.buttonMore.addTarget(self, action: #selector(actionDiscountsMore(_:)), for: .touchUpInside)
                return cell
            }
            return UICollectionViewCell()
		}

		return UICollectionViewCell()
	}
}

// MARK: - UICollectionViewDelegate
extension HomeVC: UICollectionViewDelegate {
// Bu metod, kullanıcının bir koleksiyon görünümündeki bir hücreyi seçtiğinde çağrılır.
//    Kodunuzda, belirli koleksiyon görünümlerine göre seçilen hücreleri ele almak üzere bir
//    şablon oluşturuyorsunuz.Ancak, şu anda bu metod içinde herhangi bir işlevsellik bulunmuyor;
//    yani, her bir koleksiyon görünümü için seçilen hücreyi ele alacak bir içerik eklenmemiş
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		print(#function)
		if collectionView == collectionViewSlider { }
		if collectionView == collectionViewCategories { }
		if collectionView == collectionViewDiscounts { }
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
// Bu metod, koleksiyon görünümündeki belirli bir hücre için boyutu belirlemenizi sağlar. Her bir koleksiyon görünümü için özel hücre boyutları tanımlıyorsunuz.
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		let width = collectionView.frame.size.width
		let height = collectionView.frame.size.height
		let categoriesCellWidth = (width-15)/2

		if collectionView == collectionViewSlider { return CGSize(width: width-100, height: height) }
		if collectionView == collectionViewCategories { return CGSize(width: categoriesCellWidth, height: 40) }
		if collectionView == collectionViewDiscounts { return CGSize(width: categoriesCellWidth, height: categoriesCellWidth+30) }

		return CGSize.zero
	}
// Bu metod, koleksiyon görünümündeki belirli bir bölüm (section) için minimum satır aralığını (minimum line spacing) belirlemenizi sağlar.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionViewSlider { return 15 }
        if collectionView == collectionViewCategories { return 15 }
        if collectionView == collectionViewDiscounts { return 15 }

        return 0
    }
//    // minimumLineSpacingForSectionAt:Bu metot, koleksiyon görünümündeki 
//    satırlar (rows) arasındaki minimum boşluğu belirler.Yani, bir satırdan diğerine geçişteki dikey boşluğu kontrol eder.
//    // minimumInteritemSpacingForSectionAt:Bu metot, koleksiyon görünümündeki 
//    ara öğeler (interitem) arasındaki minimum boşluğu belirler.Yani,
//    aynı satırdaki iki öğe arasındaki yatay boşluğu kontrol eder.
//// Bu metod, koleksiyon görünümündeki belirli bir bölüm (section) için minimum
//    interitem spacing (minimum ara öğe boşluğu) değerini belirlemenizi sağlar.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionViewSlider { return 15 }
        if collectionView == collectionViewCategories { return 15 }
        if collectionView == collectionViewDiscounts { return 15 }

        return 0
    }
//    // Bu metod, belirli bir koleksiyon görünümündeki belirli bir bölüm (section) 
//    için iç boşlukları (inset) belirlemenizi sağlar. Yani, koleksiyon görünümünün
//    belirli bir bölümü için içeri gömme (padding) sağlar.
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

		if collectionView == collectionViewSlider { return UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50) }
		if collectionView == collectionViewCategories { return UIEdgeInsets.zero }
		if collectionView == collectionViewDiscounts { return UIEdgeInsets.zero }

		return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	}
}

// MARK: - UIScrollViewDelegate
extension HomeVC: UIScrollViewDelegate {

	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

	}
}
