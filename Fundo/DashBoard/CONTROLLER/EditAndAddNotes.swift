//
//  NoteVC.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/7/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit
import UserNotifications

class EditAndAddNotes: UIViewController {
    
    @IBOutlet weak var noteTxtFld: UITextField!
    @IBOutlet weak var titleTxtFld: UITextField!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    @IBOutlet weak var archiveSwitch: UISwitch!
    @IBOutlet weak var inputDateFld: UITextField!
    @IBOutlet weak var pinSwitch: UISwitch!
    var noteToEdit : Note?
    var titleData = ""
    var descData = ""
    var isEditable = false
    var color:String = "FFFFFF"
    var isPinned:Bool = false
    var isArchived:Bool = false
    var noteHelper = NoteDataHelper()
    var datePicker:UIDatePicker!
    let current = Calendar.current
    var noteRemainder:Date?
    let center = UNUserNotificationCenter.current()
    var colorData:[UIColor] = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.8795216182),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 0.7726080908),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1),#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)]
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingData()
        setDatePicker()
        colorToView()
        colorCollectionView.reloadData()
    }
   private func bindingData()  {
        
        noteTxtFld.text = noteToEdit?.description ?? ""
        titleTxtFld.text = noteToEdit?.title ?? ""
        pinSwitch.setOn(noteToEdit?.isPinned ?? false, animated: true)
        archiveSwitch.setOn(noteToEdit?.isArchived ?? false, animated: true)
//        inputDateFld.text = (noteToEdit?.remainder) as! String ?? ""

    }
  
    private func setupGesture(){
        _ = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gesture:)))
    }
    @objc private func viewTapped(gesture:UITapGestureRecognizer){
        view.endEditing(true)
    }
    private func requestForAuthorization() {
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("permission granted")
            } else {
                print("permission not granted")
            }
            
            guard let error = error  else { return }
            print(error.localizedDescription)
        }
    }
    private func setDatePicker()
    {
        requestForAuthorization()
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(dateValueChanged(datePicker:)), for: .valueChanged)
        inputDateFld.inputView = datePicker
        registerNotification(date: datePicker.date)
        
    }
    @objc func dateValueChanged(datePicker: UIDatePicker){
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat  = "yyyy-mm-dd hh:mm:ss"
        inputDateFld.text = dateFormat.string(from: datePicker.date)
        noteRemainder = dateFormat.date(from: inputDateFld.text ?? "")
        datePicker.endEditing(true)
        
    }
    private func registerNotification(date: Date) {
       
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Do you want the system to send notification"
        content.categoryIdentifier = "alarm"
        content.sound = .default
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request) { error in
            
            guard let error = error else { return }
            print(error.localizedDescription)
            
        }
    }
    private func colorToView(){
        if isEditable {
            view.backgroundColor = UIColor.init(hex: noteToEdit?.color ?? "")
        }else{
            view.backgroundColor = UIColor.white
        }
    }
    @IBAction func pinNote(_ sender: UISwitch) {
        isPinned = sender.isOn
    }
    
    @IBAction func archiveNote(_ sender: UISwitch) {
        isArchived = sender.isOn
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let title = titleTxtFld.text, let noteDescription = noteTxtFld.text else {
            print("function returned")
            return }

        print(datePicker.date)
        var noteDetails = Note(title: title , description: noteDescription, color: color, isPinned: isPinned,isArchived: isArchived,remainder: datePicker.date  )
        if isEditable {
            noteDetails.updateId(noteId: noteToEdit!.noteId)
            noteHelper.updateNote(updateNote: noteDetails)
        }else{
            noteHelper.saveNote(note: noteDetails)
        }
        
    }
}
extension EditAndAddNotes:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ColorCollectionViewCell  = colorCollectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! ColorCollectionViewCell
        cell.backgroundColor = colorData[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        switch indexPath.row {
        case ColorIndex.Default.rawValue:
            color = ColorsValue.defaultNote.rawValue
        case ColorIndex.blue.rawValue:
            color = ColorsValue.blueNote.rawValue
        case ColorIndex.blueGreen.rawValue:
            color = ColorsValue.blueGreenNote.rawValue
        case ColorIndex.darkBlue.rawValue :
            color = ColorsValue.darkBlueNote.rawValue
        case ColorIndex.grey.rawValue :
            color = ColorsValue.greyNote.rawValue
        case ColorIndex.orange.rawValue:
            color = ColorsValue.orangeNote.rawValue
        case ColorIndex.pink.rawValue:
            color = ColorsValue.pinkNote.rawValue
        case ColorIndex.red.rawValue:
            color = ColorsValue.redNote.rawValue
        case ColorIndex.violet.rawValue:
            color = ColorsValue.violetNote.rawValue
        case ColorIndex.yellow.rawValue:
            color = ColorsValue.yellowNote.rawValue
        case ColorIndex.lightBlue.rawValue:
            color = ColorsValue.lightBlueNote.rawValue
        default:
            color = ColorsValue.defaultNote.rawValue
        }
        view.backgroundColor = UIColor.init(hex: color)
        
    }
}

extension EditAndAddNotes{
    enum ColorIndex:Int{
        case Default = 0
        case blue = 1
        case darkBlue = 2
        case lightBlue = 3
        case red = 4
        case pink = 5
        case blueGreen = 6
        case violet = 7
        case orange = 8
        case grey = 9
        case yellow = 10
    }
    enum ColorsValue:String{
        case defaultNote = "FFFFFF"
        case blueNote = "42C1F7"
        case darkBlueNote = "1A4766"
        case lightBlueNote = "3DACF7"
        case redNote = "FF2600"
        case pinkNote = "CE0755"
        case blueGreenNote = "73FDFF"
        case violetNote = "8E5AF7"
        case orangeNote = "F07F5A"
        case greyNote = "999999"
        case yellowNote = "F3AF22"
    }
}
