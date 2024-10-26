
import UIKit

class RootViewController: UITabBarController {

    override public func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
    }

    func setupViewControllers() {

        UITabBar.appearance().tintColor = UIColor.orange
        let firstVC = HomeVC()

        firstVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "09_home")?.resizeImage(newWidth: 36), tag: 0)

        let secondVC = EventCollectionView()

        secondVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "09_events")?.resizeImage(newWidth: 36), tag: 0)

        let thirdVC = AccountVC()

        thirdVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "09_user")?.resizeImage(newWidth: 36), tag: 0)

        let petsHomeVC = PetsHomeVC()

        petsHomeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "09_search")?.resizeImage(newWidth: 36), tag: 0)

        viewControllers = [firstVC, secondVC, thirdVC, petsHomeVC]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension RootViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Handle the user selecting a different tab
    }
}

extension UIImage {
    func resizeImage(newWidth: CGFloat) -> UIImage {

        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    } }
