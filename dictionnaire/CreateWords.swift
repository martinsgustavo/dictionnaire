
import UIKit

class CreateWords: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var wordFrench: UITextField!
    @IBOutlet weak var wordEnglish: UITextField!
    
    var subjText = ""
    var arrFrench = [String]()
    var arrEnglish = [String]()
    let defObjFrench = UserDefaultsManager()
    let defObjEnglish = UserDefaultsManager()
    let subjectMem = UserDefaultsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageUserDef()
        subject.text = subjText
    }
    @IBAction func createDictionnary(_ sender: UIButton) {
        if wordFrench.text != "" && wordEnglish.text != "" {
        arrFrench.append(wordFrench.text!)
        arrEnglish.append(wordEnglish.text!)
        defObjFrench.setKey(theValue: arrFrench as AnyObject, theKey: "french")
        defObjEnglish.setKey(theValue: arrEnglish as AnyObject, theKey: "english")
        }
        cleanerFields()
    }
    func cleanerFields() {
        wordFrench.text = ""
        wordEnglish.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if subject.text != "" {
            subjText = subject.text!
            subjectMem.setKey(theValue: subjText as AnyObject, theKey: "subject")
        }
    }
    
    func manageUserDef() {
        if defObjFrench.doesKeyExist(theKey: "french") {
            arrFrench = defObjFrench.getValue(theKey: "french") as! [String]
        }
        
        if defObjEnglish.doesKeyExist(theKey: "english") {
            arrEnglish = defObjEnglish.getValue(theKey: "english") as! [String]
        }
        
        if subjectMem.doesKeyExist(theKey: "subject") {
            subjText = subjectMem.getValue(theKey: "subject") as! String
        }
    }
}
