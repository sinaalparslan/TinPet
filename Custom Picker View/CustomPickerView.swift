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

class CustomPickerView: UIViewController {
    // ui elemetleri çalışmayacak çünkü clasımız çağrıldı ama uı kısmı yüklenmedi o yüzden picker view ve labelName oluturduk viewdidload da setleyebildik
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var labelTitle: UILabel!

    private var myItems: [String] = []
    private var labelName: String?

    var selectedItem: String?
    var didTypeSelected: ((String?) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshPickerView()
        labelTitle.text = labelName
    }

    func setup(with elements: [String], labelName: String? = "") {
        myItems = elements
        self.labelName = labelName
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

        didTypeSelected?(selectedItem ?? myItems.first)
        dismiss(animated: true)
    }
}

// MARK: - UIPickerViewDataSource
extension CustomPickerView: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        myItems.count
    }
}

// MARK: - UIPickerViewDelegate

extension CustomPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItem = myItems[row]
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        let label = UILabel()
        label.text = myItems[row]
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }
}
