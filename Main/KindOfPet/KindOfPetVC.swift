

import UIKit

class KindOfPetVC: UIViewController {

	@IBOutlet var tableView: UITableView!

	private var searchController = UISearchController()
	private var topics: [String] = []
	private var indexPaths: Set<IndexPath> = []
    var myType: TypePet?
    var didSelectedKind: ((String) -> Void)?
    var selectedIndexPath: IndexPath?
    var selectedkind: String?
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Topics"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .always

		searchController.delegate = self
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false

		loadData()
	}

	// MARK: - Data methods
	func loadData() {

		topics.removeAll()
        if myType?.rawValue == "Dog" {
            topics = DogsData().data }
        if myType?.rawValue == "Cat" {
            topics = CatsData().data }
		refreshTableView()
	}

	// MARK: - Refresh methods
	func refreshTableView() {

		tableView.reloadData()
	}
}

// MARK: - UITableViewDataSource

extension KindOfPetVC: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {

		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return topics.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell")
		if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: "cell") }

		cell.textLabel?.text = topics[indexPath.row]
		cell.accessoryType = (indexPaths.contains(indexPath)) ? .checkmark : .none
		cell.tintColor = AppColor.Theme
		cell.selectionStyle = .none

		return cell
	}
}

// MARK: - UITableViewDelegate

extension KindOfPetVC: UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

		return 45
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let currentSelectedIndexPath = selectedIndexPath {
                indexPaths.remove(currentSelectedIndexPath)
                tableView.reloadRows(at: [currentSelectedIndexPath], with: .none)
            }
            if indexPaths.contains(indexPath) {
                indexPaths.remove(indexPath)
                selectedIndexPath = nil
            } else {
                indexPaths.insert(indexPath)
                selectedIndexPath = indexPath
                selectedkind = DogsData().data[indexPath.row]
                didSelectedKind?(selectedkind ?? "")
            }

            tableView.reloadRows(at: [indexPath], with: .none)
        }
}

// MARK: - UISearchControllerDelegate

extension KindOfPetVC: UISearchControllerDelegate {

}
