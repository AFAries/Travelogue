//
//  AddEntryViewController.swift
//  Travelogue
//
//  Created by Patrick McIntosh on 12/1/20.
// A bit of the code stemmed/altered from https://www.youtube.com/watch?v=SbfBTp20_tk&list=PLTQyl3JwSx0K4HoZM1Nyv_-WWouAPnqhb for reference

import UIKit
import Foundation
import CoreData


//https://www.weheartswift.com/get-images-camera-photo-library/
//^Copied a bit from this along with my previous Photos Challenge to get the photos working


class AddEntryViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var descriptionText: UITextField!
    
    

    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()

    
    
    @IBAction func folderSelect(_ sender: UIButton) {
        openPhotoLibrary()

    }
    
    
    
    @IBAction func cameraSelect(_ sender: UIButton) {
        openCamera()

    }
    var trip: Trip?
    var entry: Entry?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        
        nameTextField.delegate = self
        descriptionText.delegate = self
        

        imagePicker.delegate = self
        imageView.image = nil
        
        //        var pictureFile = imageView.image

        if let entry = entry {
            let title = entry.title
            nameTextField.text = title
            descriptionText.text = entry.content
//            pictureFile = UIImage(data: entry.image!)
//            categoryText.text = category?.title
//            title = title
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        descriptionText.resignFirstResponder()
    }
    
    
    @IBAction func saveEntry(_ sender: UIBarButtonItem) {
        
        let title = nameTextField.text
        let content = descriptionText.text ?? ""
        let picture = imageView.image

        if let entry = Entry(title: title, content: content, image: picture){
            trip?.addToRawEntries(entry)
            print(content)
            do{
                try entry.managedObjectContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            }
            catch{
                print("Entry could not be created")
            }
        }
        
        
    }
    
  



    
    func openPhotoLibrary() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("Can't open photo library")
            return
        }
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera not supported by this device")
            return
        }
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true)
    }


}


extension AddEntryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // get the image
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        // do something with it
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        defer {
            picker.dismiss(animated: true)
        }
        print("did cancel")
    }
}
