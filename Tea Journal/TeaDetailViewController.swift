//
//  TeaDetailViewController.swift
//  Tea Journal
//
//  Created by Polina Fiksson on 05/03/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit

class TeaDetailViewController: UIViewController {
    
    var tea:TeaMO!
    var teas:[TeaMO] = []
    
     var message: String = "Write something....."
  
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var teaLabel: UILabel!
    @IBOutlet weak var addNoteButton: UIButton!
    
    @IBOutlet weak var myNote: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageBackground.image = UIImage(data: tea.image as! Data)
        
        //display the tea name in the navigation bar
        title = tea.name
        teaLabel.text = "  \(tea.name!) from \(tea.brand!)"
        
        myNote.text = message
        navigationController?.hidesBarsOnSwipe = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        myNote.text = tea.tastingNote
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func close(segue:UIStoryboardSegue) {
        
            //tea.haveTried = true
            //tea.tastingNote = tea.tastingNote
    }
    
    @IBAction func unwindToDetail(_ segue : UIStoryboardSegue) {
        if let from = segue.source as? NoteViewController {
            if let text = from.noteView.text {
                message = "\(text)"
                tea.tastingNote = message
                tea.haveTried = true
            }
            
        }
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            appDelegate.saveContext()
        }
        
    }


}
