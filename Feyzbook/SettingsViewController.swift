//
//  SettingsViewController.swift
//  Feyzbook
//
//  Created by Feyzullah Durası on 11.05.2024.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cikisYapTiklandi(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
            
        } catch {
            print("hata")
        }
        
    }

}
