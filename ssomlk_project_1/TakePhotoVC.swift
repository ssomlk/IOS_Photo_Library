//
//  TakePhotoVC.swift
//  ssomlk_project_1
//
//  Created by Wijekoon Mudiyanselage Shanka Primal Somasiri on 2/11/17.
//  Copyright © 2017 Wijekoon Mudiyanselage Shanka Primal Somasiri. All rights reserved.
//

import UIKit
import CoreData

class TakePhotoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgViewSelection: UIImageView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgViewSelection.image = image
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func imageSelection(_ sender: UITapGestureRecognizer) {
        let controller = UIImagePickerController()
        controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
        controller.allowsEditing = false
        controller.delegate = self;
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func saveData(_ sender: UIButton) {
        if validateInputTextFields() {
            saveToDatabase()
        }else{
            
        }
    }
    
    func getDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
    
        return formatter.string(from: date)
    }
    
    func validateInputTextFields() -> Bool {
        if self.txtTitle.text == "" || self.txtLocation.text == "" {
            return false
        }
        return true;
    }
    
    func saveToDatabase() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "ImageMedia", into: context)
        
        entity.setValue(self.txtTitle.text, forKey: "title")
        entity.setValue(self.txtLocation.text, forKey: "location")
        entity.setValue(self.getDate(), forKey: "createddate")
        
        let image = UIImageJPEGRepresentation(self.imgViewSelection.image!, 1)
        entity.setValue(image, forKey: "image")
        
        do {
            try context.save()
            print("done")
        } catch {
            print("Error")
        }
    }
    

}
