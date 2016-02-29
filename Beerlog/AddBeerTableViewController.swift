//
//  AddBeerTableViewController.swift
//  Beerlog
//
//  Created by Janusz Grzesik on 29.02.2016.
//  Copyright © 2016 jg. All rights reserved.
//

import UIKit

class AddBeerTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var ratingStepper: UIStepper!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        ratingImageView.image = ImageHelper.getImageForRating(Int(sender.value))
    }
    
    var categories = [Category]()
    
    func saveBeer() {
        var beerImageData: NSData?
        if mainImageView.image != nil{
            beerImageData = UIImageJPEGRepresentation(mainImageView.image!, 1)
        }
        BeerDao.saveBeer(titleTextField.text!,
            story: descriptionTextField.text!,
            rating: getValueOfRatingStepper(),
            category: getCategoryFromPicker(),
            imageData: beerImageData)
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ratingImageView.image = ImageHelper.getImageForRating(getValueOfRatingStepper())
        imagePicker.delegate = self
        categories = CategoryDao.getAllCategories()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getValueOfRatingStepper()->Int{
        return Int(self.ratingStepper.value)
    }
    
    func getCategoryFromPicker() -> Category{
        return categories[categoryPicker.selectedRowInComponent(0)]
    }
    
    // MARK: - PickerView
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveBeer" {
            saveBeer()
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]){
        var image = info[UIImagePickerControllerEditedImage] as? UIImage
        if image == nil{
            image = info[UIImagePickerControllerOriginalImage ] as? UIImage
        }
        mainImageView.contentMode = .ScaleAspectFit
        mainImageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func takePhotoTouched(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .Camera
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func loadImageButtonTapped(sender: AnyObject) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }

}