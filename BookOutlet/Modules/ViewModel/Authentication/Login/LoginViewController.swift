//
//  LoginViewController.swift
//  BookOutlet
//
//  Created by Luis Fernando Salas Gave on 14/12/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginClicked(_ sender: UIButton) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                let alert = UIAlertController(
                    title: "Dear User", message: "Please verify your email account or password", preferredStyle: .alert
                )
                let action = UIAlertAction(
                    title: "Thank you!", style: .default, handler: nil
                )
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                print("Error")
                //self.performSegue(withIdentifier: "goToNext", sender: self)
            } else {
                //Go to home screen
                self.performSegue(withIdentifier: "goToNext", sender: self)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
