//
//  DatabaseHelper.swift
//  libraryLoanAmr
//
//  Created by Ammar on 12/05/22.
//

import CoreData
import UIKit

class DatabaseHelper {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveImage(data: Data) {
        let imageInstance = Image(context: context)
        imageInstance.img = data
        do {
            try context.save()
            print("Image is saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage() -> [Image] {
          var fetchingImage = [Image]()
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
          
          do {
              fetchingImage = try context.fetch(fetchRequest) as! [Image]
          } catch {
              print("Error while fetching the image")
          }
          
          return fetchingImage
      }
    
    func deleteAllData(entity: String)
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
           fetchRequest.returnsObjectsAsFaults = false
           do {
               let results = try context.fetch(fetchRequest)
               for object in results {
                   guard let objectData = object as? NSManagedObject else {continue}
                   context.delete(objectData)
               }
           } catch let error {
               print("Detele all data in \(entity) error :", error)
           }
    }


}
