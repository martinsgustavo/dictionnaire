//----
import UIKit
//----
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //Les connexions
    @IBOutlet weak var subjTittle: UILabel!
    @IBOutlet weak var tabView: UITableView!
    @IBOutlet weak var translation: UILabel!
    //Variables pour le dictionnaire
    var dictOfWords = [String: String]()
    //Variables pour les tableaux dans dictionnaire
    var arrOfFrench = [String]()
    var arrOfEnglish = [String]()
    //Variable pour le sujet
    var subjText = ""
    //Constantes pour garder le dictionnaire et le sujet
    let defObjFrench = UserDefaultsManager()
    let defObjEnglish = UserDefaultsManager()
    let subjectMem = UserDefaultsManager()
//----
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialiser avec des mots écrits en mémoire
        manageUserDef()
        translation.text! = "cliquez sur le mot pour voir la traduction"
        translation.textColor = UIColor.gray
        subjTittle.text = subjText
        //Créer un dictionnaire
        dictOfWords = Dictionary (uniqueKeysWithValues: zip(arrOfFrench, arrOfEnglish))
        //Rafraîchir le tableView
        tabView.reloadData()
    }
//----
    //Action pour le choix de la langue
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
//----
    //Fonction pour compter les éléments dans tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictOfWords.count
    }
//----
    //Fonction pour afficher les mots dans tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell (style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = [String](dictOfWords.keys)[indexPath.row]
        return cell
    }
//----
    //Fonction pour afficher les mots traduits dans le Label
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        translation.text = [String](dictOfWords.values)[indexPath.row]
        translation.textColor = UIColor.black
    }
//----
    //Fonction pour capturer des informations stockées dans la mémoire
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

}




