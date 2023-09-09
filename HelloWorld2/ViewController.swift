//
//  ViewController.swift
//  HelloWorld2
//
//  Created by 修昊 on 2023/9/9.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var helloLabel: NSTextField!
    
    @IBOutlet weak var postNameField: NSTextField!
    
    let blogDir: String = "/opt/homebrew/bin/hugo"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func sayButtonClicked(_ sender: Any) {
        var name = nameField.stringValue
        if name.isEmpty {
            name = "World"
        }
        let greeting = "Hello \(name)!"
        print(greeting)
        helloLabel.stringValue = greeting
    }
    
    // create new post
    @IBAction func newPostClicked(_ sender: Any) {
        let postName = postNameField.stringValue
        if postName.isEmpty {
            helloLabel.stringValue = "No Post Name"
        }
        
        let task = Process()
        let fileManager = FileManager.default
        let hugoPath = "hugo"
        
        // 检查是否存在 hugo
        if !fileManager.fileExists(atPath: hugoPath) {
            print("hugo file not exist.")
        }
        
        task.executableURL = URL(fileURLWithPath: hugoPath)
        task.arguments = ["new", postName]
        task.currentDirectoryURL = URL(fileURLWithPath: blogDir)
        
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        task.standardOutput = outputPipe
        task.standardError = errorPipe
        
        do {
            try task.run()
            task.waitUntilExit()
        } catch {
            print(error)
        }
    }
    
    @IBAction func listPostClicked(_ sender: Any) {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/local/bin/code")
        task.arguments = [blogDir,]
        
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        task.standardOutput = outputPipe
        task.standardError = errorPipe
        
        do {
            try task.run()
            task.waitUntilExit()
        } catch {
            print(error)
            print("task run error.")
        }
        
    }
}

