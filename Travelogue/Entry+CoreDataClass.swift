//
//  Entry+CoreDataClass.swift
//  Travelogue
//
//  Created by Patrick McIntosh on 12/9/20.
//
//

import UIKit
import CoreData

@objc(Entry)
public class Entry: NSManagedObject {
    
    func imageConvert(_ image: UIImage?)->Data?{
       return image?.pngData()
    }
    
    convenience init?(title: String?, content: String?, image: UIImage?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext
            else{
                return nil
        }
        self.init(entity: Entry.entity(), insertInto: context)
        self.title = title
        self.content = content
        self.image = imageConvert(image)
//        self.size = Int64(content!.count)
        self.rawDate = Date(timeIntervalSinceNow: 0)
    }
    
    func updateDocument(title: String?, content: String?, image: UIImage?) {
            self.title = title
            self.content = content
            self.image = imageConvert(image)
//            self.size = Int64(content!.count)
            self.rawDate = Date(timeIntervalSinceNow: 0)
            
    }
    
}


//    var date: Date?{
//        get{
//            return rawDate as Date?
//        }
//        set{
////            rawDate = newValue as NSDate?
//            rawDate = newValue as Date?
//        }
//    }
//    convenience init?(title: String?, content: String?, date: Date?, image: Data) {
//        let appDelegate = UIApplication.shared.delegate as? AppDelegate
//
//        guard let context = appDelegate?.persistentContainer.viewContext
//        else{
//            return nil
//
//        }
//        self.init(entity: Entry.entity(), insertInto: context)
//
//        self.title = title;
//        self.content = content;
//        self.date = date;
//        self.image = image;
//    }
