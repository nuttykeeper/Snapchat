//
//  PictureViewController.swift
//  Snapchat
//
//  Created by Michael Shepherd on 25/05/2017.
//  Copyright © 2017 Shepherd Apps. All rights reserved.
//

import UIKit
import FirebaseStorage

class PictureViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func nextTapped(_ sender: Any) {
        
        nextButton.isEnabled = false
        let imagesFolder = Storage.storage().reference().child("images")
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        

        imagesFolder.child("\(NSUUID().uuidString).jpg").putData(imageData, metadata: nil, completion: { (metaData, error) in
            
            print("We tried to upload")
            if error != nil {
                print("We have an error: \(String(describing: error))")
            }
            else{
                self.performSegue(withIdentifier: "selectUsersegue", sender: nil)
            }
            
        })
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
}
