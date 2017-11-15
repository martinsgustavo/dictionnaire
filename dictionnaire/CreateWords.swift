//-----
import UIKit
//-----
class CreateWords: UIViewController, UITextFieldDelegate{
    //Les connexions
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var wordFrench: UITextField!
    @IBOutlet weak var wordEnglish: UITextField!
    //Variable pour le sujet
    var subjText = ""
    //Variables pour les tableaux dans dictionnaire
    var arrFrench = [String]()
    var arrEnglish = [String]()
    //Constantes pour garder le dictionnaire et le sujet
    let defObjFrench = UserDefaultsManager()
    let defObjEnglish = UserDefaultsManager()
    let subjectMem = UserDefaultsManager()
    
//-----
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialiser avec des mots écrits en mémoire
        manageUserDef()
        subject.text = subjText
    }
//-----
    //Bouton pour enregistrer les nouveaux mots dans les tableaux
    @IBAction func createDictionnary(_ sender: UIButton) {
        if wordFrench.text != "" && wordEnglish.text != "" {
        arrFrench.append(wordFrench.text!)
        arrEnglish.append(wordEnglish.text!)
        defObjFrench.setKey(theValue: arrFrench as AnyObject, theKey: "french")
        defObjEnglish.setKey(theValue: arrEnglish as AnyObject, theKey: "english")
        }
        cleanerFields()
    }
//-----
    //Vider les champs
    func cleanerFields() {
        wordFrench.text = ""
        wordEnglish.text = ""
    }
//-----
    //Fonction pour fermer le clavier
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
//-----
    //Fonction pour garder le sujet dans le mémoire
    func textFieldDidEndEditing(_ textField: UITextField) {
        if subject.text != "" {
            subjText = subject.text!
            subjectMem.setKey(theValue: subjText as AnyObject, theKey: "subject")
        }
    }
//-----
    //Fonction pour capturer des informations stockées dans la mémoire
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
//-----
}
//-----
