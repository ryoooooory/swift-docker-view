//
//  ViewController.swift
//  Demo
//
//  Created by Ryo Oshima on 2022/07/09.
//

import UIKit
import DockerView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let dockerView = DockerView()
        view.addSubview(dockerView)
        dockerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dockerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40.0).isActive = true
    }

}
