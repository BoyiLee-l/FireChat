//
//  RegistrationController.swift
//  FireChat
//
//  Created by user on 2021/9/6.
//

import UIKit
import SnapKit

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel = RegistrationViewModel()
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type:  .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        button.imageView?.clipsToBounds = true
        return button
    }()
    
    private lazy var emailContainerView: InputContainerView = {
        return InputContainerView(image: UIImage(systemName: "envelope"),
                                  textField: emailTextField)
    }()
    
    private lazy var passwordContainerView: InputContainerView = {
        return InputContainerView(image: UIImage(systemName: "lock"),
                                  textField: passwordTextField)
    }()
    
    private lazy var fullnameContainerView: InputContainerView = {
        return InputContainerView(image: UIImage(named: "ic_person_outline_white_2x"),
                                  textField: fullnameTextField)
    }()
    
    private lazy var usernameContainerView: InputContainerView = {
        return InputContainerView(image: UIImage(named: "ic_person_outline_white_2x"),
                                  textField: usernameTextField)
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let fullnameTextField = CustomTextField(placeholder: "Full Name")
    private let usernameTextField = CustomTextField(placeholder: "UserName")
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let btn = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ",
                                                        attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                                     .foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Log In",
                                                  attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                               .foregroundColor: UIColor.white]))
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Lifeycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        configureGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(32)
            make.width.height.equalTo(200)
        }
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   fullnameContainerView,
                                                   usernameContainerView,
                                                   signUpButton])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(plusPhotoButton.snp.bottom).offset(32)
            make.right.equalTo(view).offset(-32)
            make.left.equalTo(view).offset(32)
        }
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-32)
            make.left.equalTo(view).offset(32)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureNotificationObservers() {
        
    }
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        plusPhotoButton.layer.cornerRadius = 200 / 2
        
        dismiss(animated: true)
    }
}

