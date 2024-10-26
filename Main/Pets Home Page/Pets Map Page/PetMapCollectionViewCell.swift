

import UIKit
import MapKit
class PetMapCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var buttonOpenMaps: UIButton!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet var imagePets: UIImageView!
	@IBOutlet var labelName: UILabel!
	@IBOutlet var labelInfo: UILabel!
	@IBOutlet var labelDistance: UILabel!
    @IBOutlet weak var viewDistanceBorder: UIView!

    var data: AnimalModel?
    // awakeFromNib metodunun kullanım amacı, bir nesne, örnek veya görünüm yerleştirildiğinde,
    // ancak bağlantıları kurulduktan veya başka önemli ayarlamalar yapıldıktan sonra çağrılır.
	override func awakeFromNib() {
		super.awakeFromNib()
        viewDistanceBorder.layer.borderWidth = 1
        viewDistanceBorder.layer.borderColor = AppColor.Border.cgColor
        viewDistanceBorder.cornerRadius = viewDistanceBorder.bounds.height / 2
	}

    @IBAction func actionOpenMap(_ sender: Any) {
        let placemark = MKPlacemark(coordinate: (data?.get2DLocation())!)
        let mapItem = MKMapItem(placemark: placemark)

        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }

    func bindData(index: Int, data: AnimalModel, distance: Double?) {
        self.data = data
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let birthDate = dateFormatter.date(from: data.birthDate ?? "") {
            let secondsInYear: TimeInterval = 365.25 * 24 * 60 * 60
            let ageInSeconds = currentDate.timeIntervalSince(birthDate)
            let ageInYears = Int(ageInSeconds / secondsInYear)
            labelAge.text = "Age: " + String(ageInYears)

        }
        labelType.text = data.type
        labelGenre.text = data.genre
        labelName.text = data.name
        labelInfo.text = data.coverLater
        if let dis = distance {
            let disM = dis/1000
            let disMS = String(format: "%.2f", disM)
            labelDistance.text = disMS + " Km"
            labelDistance.isHidden = false
        } else {
            labelDistance.isHidden = true
        }

        imagePets.image = UIImage(named: "09_ProfilData")

        let randomInt = Int.random(in: 0..<300)
        let url = "https://picsum.photos/id/\(randomInt)/600/200"
        if let url = url.toURL() {
            imagePets.load(url: url)
        }
    }
}
