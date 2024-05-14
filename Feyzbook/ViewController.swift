//
//  ViewController.swift
//  Feyzbook
//
//  Created by Feyzullah Durası on 11.05.2024.
//

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
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: sifreTextField.text!) { AuthDataResult, error in
                if error != nil {
                    self.hataMesaji(titleInput: "Hata!", messageInput: "Kullanıcı Adı ve Şifre Giriniz!")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            hataMesaji(titleInput: "Hata!", messageInput: "Kullanıcı Adı ve Şifre Giriniz!")
        }
        
    }
    
    @IBAction func kayitOlTiklandi(_ sender: Any) {
        
        if emailTextField.text != "" && sifreTextField.text != "" {
            // kayit işlemi
            Auth.auth().createUser(withEmail: emailTextField.text!, password: sifreTextField.text!) { authdataresult, error in
                if error != nil {
                    self.hataMesaji(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata aldınız, tekrar deneyiniz")
                    
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
            }
        } else {
            hataMesaji(titleInput: "Hata!", messageInput: "Kullanıcı Adı ve Şifre Giriniz!")
        }
        
    }
    func hataMesaji(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
}

