//
//  NoteViewController.swift
//  Tea Journal
//
//  Created by Polina Fiksson on 05/03/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate {
    
    var tea:TeaMO!

    @IBOutlet weak var noteView: UITextView!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        backView.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        closeButton.transform = CGAffineTransform.init(translationX: 1000, y: 0)
        
    }
    
    //create the growing effect
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            // define the final state of the dialog view
            self.backView.transform = CGAffineTransform.identity
        })
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            
            self.closeButton.transform = CGAffineTransform.identity
            
        }, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            noteView.text = noteView.text
            
        }
        
        return true
        
    }
 

}
