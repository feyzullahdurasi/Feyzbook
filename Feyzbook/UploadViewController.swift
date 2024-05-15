import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var yorumTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func gorselSec() {
        let pickerContoller = UIImagePickerController()
        pickerContoller.delegate = self
        pickerContoller.sourceType = .photoLibrary
        present(pickerContoller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadButtonTiklandi(_ sender: Any) {
        
        guard let selectedImage = imageView.image else {
            hataMesajGoster(title: "Hata", message: "Lütfen bir resim seçin.")
            return
        }
        
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else {
            hataMesajGoster(title: "Hata", message: "Resim verisi alınamadı.")
            return
        }
        
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder = storageReferance.child("media")
        
        let uuid = UUID().uuidString
        let imageReference = mediaFolder.child("\(uuid).jpg")
        
        imageReference.putData(imageData, metadata: nil) { (storagemetadata, error) in
            if let error = error {
                self.hataMesajGoster(title: "Hata", message: error.localizedDescription)
            } else {
                imageReference.downloadURL { (url, error) in
                    if let error = error {
                        self.hataMesajGoster(title: "Hata", message: error.localizedDescription)
                    } else if let imageUrl = url?.absoluteString {
                        
                        let firestoreDatabase = Firestore.firestore()
                        
                        let firestorePost = [
                            "gorselUrl" : imageUrl,
                            "yorum" : self.yorumTextField.text ?? "",
                            "email" : Auth.auth().currentUser?.email ?? "",
                            "tarih" : FieldValue.serverTimestamp()
                        ] as [String : Any]
                        
                        firestoreDatabase.collection("Post").addDocument(data: firestorePost) { (error) in
                            if let error = error {
                                self.hataMesajGoster(title: "Hata", message: error.localizedDescription)
                            } else {
                                self.imageView.image = UIImage(named: "gorselsec")
                                self.yorumTextField.text = ""
                                self.tabBarController?.selectedIndex = 0
                            }
                        }
                    } else {
                        self.hataMesajGoster(title: "Hata", message: "Resim URL'si alınamadı.")
                    }
                }
            }
        }
    }
    
    func hataMesajGoster(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
