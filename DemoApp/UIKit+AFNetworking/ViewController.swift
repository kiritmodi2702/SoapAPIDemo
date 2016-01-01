//
//  ViewController.swift
//  SoapTestingDemo
//
//  Created by Nimble Chapps on 30/10/15.
//  Copyright (c) 2015 Nimble Chapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var txtBookName: UITextField!
    
    @IBOutlet weak var txtChapterName: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @IBAction func clickSubmit(sender: AnyObject) {
        
        
        if isCheckNull(){
            
            self.callSoapAPI(txtBookName.text!, chapter: txtChapterName.text!)
        }
        else{
            
            UIAlertView(title: "BooksDetailsq", message: "Please enter Book Name : ", delegate: nil, cancelButtonTitle: "OK").show()
        }
        
    }

    func isCheckNull()->Bool{
        

        if txtBookName.text?.characters.count > 0{
            
            return true
        }
        else{
            
            return false
        }
    }
    
    
    func callSoapAPI(bookName : String , chapter : String){
        
        
        // Soap Boday
        
        let soapMessage =  "<?xml version='1.0' encoding='UTF-8'?><SOAP-ENV:Envelope xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ns1='http://www.prioregroup.com/'><SOAP-ENV:Body><ns1:GetVerses><ns1:BookName>\(bookName)</ns1:BookName><ns1:chapter>\(chapter)</ns1:chapter></ns1:GetVerses></SOAP-ENV:Body></SOAP-ENV:Envelope>"
        
        let soapLenth = String(soapMessage.characters.count)
        let theUrlString = "http://www.prioregroup.com/services/americanbible.asmx"
        let theURL = NSURL(string: theUrlString)
        let mutableR = NSMutableURLRequest(URL: theURL!)
        
        // MUTABLE REQUEST
        
        mutableR.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableR.addValue("text/html; charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableR.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
        mutableR.HTTPMethod = "POST"
        mutableR.HTTPBody = soapMessage.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        // AFNETWORKING REQUEST
        
        let manager = AFHTTPRequestOperation(request: mutableR)
        manager.setCompletionBlockWithSuccess({ (operation : AFHTTPRequestOperation, responseObject : AnyObject) -> Void in
            
            
            var dictionaryData = NSDictionary()
            
            do
            {
                dictionaryData = try XMLReader.dictionaryForXMLData(responseObject as! NSData)
                
                let mainDict = dictionaryData.objectForKey("soap:Envelope")!.objectForKey("soap:Body")!.objectForKey("GetVersesResponse")!.objectForKey("GetVersesResult")   ?? NSDictionary()
                
               
                
                if mainDict.count > 0{
                    
                    let mainD = NSDictionary(dictionary: mainDict as! [NSObject : AnyObject])
                    
                    self.performSegueWithIdentifier("details", sender: mainD)
                    
                }
                else{
                
                    UIAlertView(title: "BooksDetailsq", message: "Oops! No data found.", delegate: nil, cancelButtonTitle: "OK").show()
                
                }
                
            }
            catch
            {
                print("Your Dictionary value nil")
            }
            
            print(dictionaryData)
            
            
            }, failure: { (operation : AFHTTPRequestOperation, error : NSError) -> Void in
                
                print(error, terminator: "")
        })
        
        manager.start()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let detais = segue.destinationViewController as! DetailsBooks
        
        detais.dictAll = sender! as! NSDictionary
        
    }
    
}

