//
// Copyright (c) 2021 Related Code - https://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
class MyAnimalsVC: UIViewController {

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

extension MyAnimals: UITableViewDataSource {
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

extension MyAnimals: UITableViewDelegate {

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

extension MyAnimals: UISearchControllerDelegate {

}
