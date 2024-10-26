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

enum SortingType: String, CaseIterable {
    case age = "Age"
    case distance = "Distance"
    case name = "Name"
// Bu genellikle kullanıcı arayüzünde seçeneklerin gösterilmesi veya başka bir yerde kullanılmak üzere değerleri döndürmek için kullanılır.
    static func getAllValues() -> [String] {
        return SortingType.allCases.map { $0.rawValue }
    }

    static func getAllKeys() -> [SortingType] {
        return SortingType.allCases.map { $0 }
    }
}

class LikePickerVC: UIViewController {

    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var labelTitle: UILabel!

    private var sortBy: [SortingType] = []

    var selectedItem: SortingType?
    var didSortTypeSelected: ((SortingType) -> Void)?

    override func viewDidLoad() {

        super.viewDidLoad()
        loadData()
    }

    // MARK: - Data methods
    func loadData() {

        sortBy.removeAll()
        sortBy = SortingType.getAllKeys()
        refreshPickerView()
    }

    // MARK: - Refresh methods
    func refreshPickerView() {

        pickerView.reloadAllComponents()
    }

    // MARK: - User actions
    @IBAction func actionClose(_ sender: UIButton) {

        print(#function)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func actionDone(_ sender: UIButton) {

        didSortTypeSelected?(selectedItem ?? .age)
        dismiss(animated: true)
    }
}

// MARK: - UIPickerViewDataSource
extension LikePickerVC: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        sortBy.count
    }
}

// MARK: - UIPickerViewDelegate

extension LikePickerVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItem = sortBy[row]
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        let label = UILabel()
        label.text = sortBy[row].rawValue
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }
}
