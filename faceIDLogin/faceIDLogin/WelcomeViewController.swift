//
//  WelcomeViewController.swift
//  faceIDLogin
//
//  Created by Kell Lanes on 07/07/21.
//

import UIKit

class WelcomeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textFieldTypedText: UITextField!
    @IBOutlet weak var labelTypedTextResponse: UILabel!
    @IBOutlet weak var txt1: UITextField!
    
    var parentVC: LoginViewController?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldTypedText.delegate = self
        txt1.delegate = self
        
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
        if let count = textField.text?.count {
            var countString = count
            if string.isEmpty{
                countString = countString - 1
            } else {
                countString = countString + string.count
            }
            labelTypedTextResponse.text = ("Você digitou \(countString) caracteres")
        }
       
        return true
//      EXECUTA A CADA MUDANÇA FEITA NO CAMPO
    }
    
    @IBAction func btnLogout(_ sender: Any) {
        self.parentVC?.logoutUser()
        dismiss(animated: true)
    }
    
    
    

//      TESTE
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//      EXECUTA AO CLICAR NO CAMPO
        print("O usuário clicou no campo ")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//      PRONTO PARA EDIÇÃO
        print("o usuário pode iniciar a edição")
//      Parece igual ao clicar no campo
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//      EXECUTA AO LIMPAR O CAMPO
        print("O usuário limpou o campo")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool  {
//      EXECUTA AO ENVIAR - ENTER/RETURN
        print("Click em Enter/Return")
        return true
    }
  

    
    //ESTAVA PEGANDO A ALTERAÇÃO E CHAMANDO NA FUNCAO DO BOTÃO TESTE
    //    func textFieldDidChange(textField: UITextField) {
    //        let newString = textFieldTypedText.text
    //        let countString = Int(newString?.count ?? 0)
    //            if countString >= 0 {
    //                labelTypedTextResponse.text = ("Você digitou \(countString) caracteres")
    //            } else {
    //                labelTypedTextResponse.text = ("Você digitou 0 caracteres")
    //            }
    //    }
    //
    //    @IBAction func botaoTeste(_ sender: Any) {
    //        self.textFieldDidChange(textField: textFieldTypedText)
    //    }

        
    
}
    



