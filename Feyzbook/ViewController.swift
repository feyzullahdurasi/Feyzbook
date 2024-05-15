import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var sifreTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func girisYapTiklandi(_ sender: Any) {
        if emailTextField.text != "" && sifreTextField.text != "" {
                    
                    Auth.auth().signIn(withEmail: emailTextField.text!, password: sifreTextField.text!) { (authdata, error) in
                        if error != nil {
                            self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")

                        } else {
                            self.performSegue(withIdentifier: "toFeedVC", sender: nil)

                        }
                    }
                    
                    
                } else {
                    makeAlert(titleInput: "Error!", messageInput: "Username/Password?")

                }
    }
    
    @IBAction func kayitOlTiklandi(_ sender: Any) {
        if emailTextField.text != "" && sifreTextField.text != "" {
                    Auth.auth().createUser(withEmail: emailTextField.text!, password: sifreTextField.text!) { (authdata, error) in
                        
                        if error != nil {
                            self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                        } else {
                            self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                            
                        }
                    }
                
                } else {
                    makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
                }
    }
    
    
    func makeAlert(titleInput:String, messageInput:String) {
            let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
    }
    
}
