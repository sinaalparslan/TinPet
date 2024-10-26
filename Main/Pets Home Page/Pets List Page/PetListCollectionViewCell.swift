

import UIKit
import MapKit

class PetListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet var imageRestaurant: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelInfo: UILabel!
    @IBOutlet var viewDistance: UIView!
    @IBOutlet var labelDistance: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        if let viewDist = viewDistance {
                viewDist.layer.borderWidth = 1
                viewDist.layer.borderColor = AppColor.Border.cgColor
            } else {
                // viewDistance nil ise yapılacak işlemler
                print("Hata: viewDistance nil.")
            }
    }
    func bindData(index: Int, data: AnimalModel, distance: Double?) {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let birthDate = dateFormatter.date(from: data.birthDate ?? "") {
            let secondsInYear: TimeInterval = 365.25 * 24 * 60 * 60
            let ageInSeconds = currentDate.timeIntervalSince(birthDate)
            let ageInYears = Int(ageInSeconds / secondsInYear)
            labelAge.text  = "Age: " + String(ageInYears)

        }
//        let url = data.photos![0]
        let randomInt = Int.random(in: 0..<300)
        let url = "https://picsum.photos/id/\(randomInt)/600/200"
        if let url = url.toURL() {
            imageRestaurant.load(url: url)
        }
        labelType.text = data.type
        labelName.text = data.name
        labelInfo.text = data.coverLater
        labelGenre.text = data.genre

        if let dis = distance {
            let disM = dis/1000
            let disMS = String(format: "%.2f", disM) + " Km"
            labelDistance.text = disMS
            labelDistance.isHidden = false
        } else {
            labelDistance.isHidden = true
        }

    }
}
