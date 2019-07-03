//
//  NotesCollectionView.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/19/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

private let reuseIdentifier = "noteCell"
class NotesCollectionViewController: UICollectionViewController{
   lazy  var searchBar : UISearchBar = {
        let s = UISearchBar()
        s.placeholder = "Search Notes..."
        s.delegate = self
        s.tintColor = .white
        s.barStyle = .default
        s.sizeToFit()
        return s
    }()
    var isSearching:Bool=false
    var listOfNotes :[Note]?
    var filiteredNotes:[Note] = []
    lazy var collectionViewFlowLayout : CustomCollectionFlowLayout = {
        let layout = CustomCollectionFlowLayout(display: .list)
        return layout
    }()
    var noteHelper = NoteDataHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        initList()
        collectionView.reloadData()
        registerHeader()
        addObserver()
        collectionViewFlowLayout.headerReferenceSize  = CGSize(width:      self.collectionView.frame.size.width, height: searchBar.bounds.height)
        self.collectionView.collectionViewLayout = self.collectionViewFlowLayout
        self.view.addSubview(searchBar)
        searchBar.delegate = self

       
        
    }
   
    func registerHeader() {
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCellId")

    }
    private func addObserver(){
         NotificationCenter.default.addObserver(self, selector: #selector(layoutChanged(_:)), name: NSNotification.Name("CollectionViewLayouts"), object: nil)

    }
    
    @objc func layoutChanged(_ notification : NSNotification) {
        let selectedSegment : Int = notification.userInfo!["segmentIndex"] as! Int
        switch selectedSegment {
        case 0:
            self.collectionViewFlowLayout.display = .list
        case 1:
            self.collectionViewFlowLayout.display = .grid
        default:
            self.collectionViewFlowLayout.display = .list
        }
    }
    private func registerCell()
    {
        collectionView.register(UINib.init(nibName: "NoteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    override func viewWillAppear(_ animated: Bool) {
        initList()
        print(listOfNotes!)
        collectionView.reloadData()
    }
    private func initList() {
       listOfNotes = noteHelper.getAllNotes()
      //  listOfNotes = noteHelper.getPinnedNotes()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching{
            return filiteredNotes.count
        }else {
            return listOfNotes!.count
        }
    }
    
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:NoteCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NoteCollectionViewCell
        if isSearching{
            cell.bindNoteCard(note: filiteredNotes[indexPath.row])
            
        }else{
            cell.bindNoteCard(note: listOfNotes![indexPath.row])
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let noteVC = self.storyboard?.instantiateViewController(withIdentifier: "noteVC") as? EditAndAddNotes else {
            print("failed to navigate")
            return  }
        if isSearching {
            let note = filiteredNotes[indexPath.row]
            let cell = collectionView.cellForItem(at: indexPath) as! NoteCollectionViewCell
            noteVC.noteToEdit = note
            noteVC.isEditable = true
            noteVC.color =  cell.cellColor.toHexString()
            print(indexPath.row)
        }else{
            let note = listOfNotes![indexPath.row]
            let cell = collectionView.cellForItem(at: indexPath) as! NoteCollectionViewCell
            noteVC.noteToEdit = note
            noteVC.isEditable = true
            noteVC.color =  cell.cellColor.toHexString()
            print(indexPath.row)
        
        }
        navigationController?.pushViewController(viewController: noteVC, animated: true, completion: ({}))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: searchBar.bounds.height)
    }
   
}


