
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var subjTittle: UILabel!
    @IBOutlet weak var tabView: UITableView!
    @IBOutlet weak var translation: UILabel!
    
    var dictOfWords = [String: String]()
    var arrOfFrench = [String]()
    var arrOfEnglish = [String]()
    
    var subjText = ""
    let defObjFrench = UserDefaultsManager()
    let defObjEnglish = UserDefaultsManager()
    let subjectMem = UserDefaultsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        defObjFrench.removeKey(theKey: "french")
//        defObjFrench.removeKey(theKey: "english")
        manageUserDef()
        translation.text! = "cliquez sur le mot pour voir la traduction"
        translation.textColor = UIColor.gray
        subjTittle.text = subjText
        dictOfWords = Dictionary (uniqueKeysWithValues: zip(arrOfFrench, arrOfEnglish))
        tabView.reloadData()
    }
    @IBAction func chooseLanguage(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            dictOfWords = Dictionary (uniqueKeysWithValues: zip(arrOfFrench, arrOfEnglish))
            translation.text = "cliquez sur le mot pour voir la traduction"
            translation.textColor = UIColor.gray
            sender.setTitle("Français", forSegmentAt: 0)
            sender.setTitle("Anglais", forSegmentAt: 1)
        } else {
            dictOfWords = Dictionary (uniqueKeysWithValues: zip(arrOfEnglish, arrOfFrench))
            translation.text = "click on the word to see the translation"
            translation.textColor = UIColor.gray
            sender.setTitle("French", forSegmentAt: 0)
            sender.setTitle("English", forSegmentAt: 1)
        }
        tabView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dictOfWords.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell (style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = [String](dictOfWords.keys)[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        translation.text = [String](dictOfWords.values)[indexPath.row]
        translation.textColor = UIColor.black
    }
    
    func manageUserDef() {
        if defObjFrench.doesKeyExist(theKey: "french") {
            arrOfFrench = defObjFrench.getValue(theKey: "french") as! [String]
        }
        
        if defObjEnglish.doesKeyExist(theKey: "english") {
            arrOfEnglish = defObjEnglish.getValue(theKey: "english") as! [String]
        }
        
        if subjectMem.doesKeyExist(theKey: "subject") {
            subjText = subjectMem.getValue(theKey: "subject") as! String
        }
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.delete {
//            let cellDelete: String = tableView.cellForRow(at: indexPath)!.textLabel!.text!
//            let arrayDelete = cellDelete.split(separator: " ")
//            for i in arrayDelete {
//                if let index = dictOfWords.index(forKey: String(i)) {
//                    dictOfWords.remove(at: index)
//                    memory.setKey(theValue: dictOfWords as AnyObject, key: "Dictionnarie")
//                }
//            }
//        }
//        tabView.reloadData()
//    }

}

/// delete rows fazer isso




